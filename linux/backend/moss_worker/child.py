"""Isolated Python 3.10 MOSS process. JSON lines on stdin/stdout; logs on stderr.

One inference runs synchronously at a time. The supervisor can terminate this
process to cancel a native run and start a fresh process for subsequent work.
No queue, durable attempt, or business-service code runs here.
"""
import argparse
import json
import math
import os
import sys


def control_channel():
    sys.stdout.flush()
    control = os.fdopen(os.dup(1), 'w', encoding='utf-8', buffering=1)
    os.dup2(2, 1)
    return control


def serve(source, output, runtime_factory):
    def send(message):
        output.write(json.dumps(message, ensure_ascii=False, allow_nan=False) + '\n')
        output.flush()
    try:
        runtime = runtime_factory()
    except Exception as exc:
        send(dict(type='not_ready', error=str(exc)))
        return 1
    send(dict(type='ready', model_manifest_sha256=runtime.manifest_sha256,
              selftests=getattr(runtime, 'selftests', {})))
    try:
        for line in source:
            request_id = None
            try:
                request = json.loads(line)
                if not isinstance(request, dict):
                    raise ValueError('MOSS_INVALID_REQUEST')
                if request['type'] == 'shutdown':
                    return 0
                candidate_id = request.get('request_id')
                if request['type'] != 'infer' or not isinstance(candidate_id, str) or not candidate_id:
                    raise ValueError('MOSS_INVALID_REQUEST')
                request_id = candidate_id
                from .windowing import WindowSpec
                window = WindowSpec(**request['window'])
                runtime.on_state = lambda state: send(dict(type='state', request_id=request_id, state=state))
                result = runtime.infer_window(window, request['wav'], window_id=request.get('window_id'))
                generation = runtime.last_generation
                metadata = (dict(token_count=generation.token_count, normal_termination=generation.normal_termination,
                                 perf={key: value if math.isfinite(value) else None
                                       for key, value in generation.perf.items()},
                                 error=generation.error) if generation is not None else None)
                send(dict(type='result', request_id=request_id, result=result.to_dict(), generation_metadata=metadata))
            except (ValueError, KeyError, TypeError, OSError) as exc:
                send(dict(type='error', request_id=request_id, error=f'MOSS_INVALID_REQUEST:{exc}'))
    finally:
        runtime.close()
    return 0


def main(argv=None):
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--bundle', required=True)
    parser.add_argument('--manifest-sha256', required=True)
    parser.add_argument('--rknn-library', required=True)
    parser.add_argument('--rkllm-library', required=True)
    args = parser.parse_args(argv)
    with control_channel() as output:
        def startup():
            if sys.version_info[:2] != (3, 10):
                raise RuntimeError('MOSS_PYTHON_VERSION_UNSUPPORTED:requires_3.10')
            from .runtime import MossRuntime
            return MossRuntime.from_bundle(args.bundle, expected_manifest_sha256=args.manifest_sha256,
                                           rknn_library=args.rknn_library, rkllm_library=args.rkllm_library)
        return serve(sys.stdin, output, startup)


if __name__ == '__main__':
    raise SystemExit(main())
