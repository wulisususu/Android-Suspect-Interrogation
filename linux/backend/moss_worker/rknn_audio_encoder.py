"""One private RKNN 2.3.2 runtime per isolated, serial worker."""
from importlib.metadata import version
from pathlib import Path

import numpy as np

from .runtime import sha256_file


class RKNNEncoder:
    def __init__(self, model, *, library, expected_sha256):
        selected = Path(library).resolve(strict=True)
        if sha256_file(selected) != expected_sha256:
            raise ValueError('MOSS_NATIVE_LIBRARY_HASH_MISMATCH')
        if version('rknn-toolkit-lite2') != '2.3.2':
            raise RuntimeError('MOSS_RKNN_VERSION_UNSUPPORTED')
        from rknnlite.api import RKNNLite
        from rknnlite.api.rknn_runtime import RKNNRuntime

        self.runtime = None
        original = RKNNRuntime._get_rknn_api_lib_path
        try:
            # SDK loads an absolute /usr/lib path. Scope selection to this child's
            # single-threaded initialization and never alter installed SDK files.
            RKNNRuntime._get_rknn_api_lib_path = lambda instance: str(selected)
            self.runtime = RKNNLite()
            code = self.runtime.load_rknn(str(model))
            if code != 0:
                raise RuntimeError(f'MOSS_RKNN_LOAD_FAILED:{code}')
            code = self.runtime.init_runtime(core_mask=RKNNLite.NPU_CORE_0_1_2)
            if code != 0:
                raise RuntimeError(f'MOSS_RKNN_INIT_FAILED:{code}')
            loaded = getattr(getattr(getattr(self.runtime, 'rknn_runtime', None), 'lib', None), '_name', None)
            if loaded is None or Path(loaded).resolve() != selected or sha256_file(loaded) != expected_sha256:
                raise RuntimeError('MOSS_NATIVE_LIBRARY_PATH_MISMATCH')
        except Exception:
            self.close()
            raise
        finally:
            RKNNRuntime._get_rknn_api_lib_path = original

    def encode(self, chunk):
        features = np.asarray(chunk.features)
        if (features.shape != (1, 80, 3000) or features.dtype != np.float32
                or not np.isfinite(features).all() or type(chunk.valid_tokens) is not int
                or not 1 <= chunk.valid_tokens <= 375):
            raise ValueError('MOSS_INVALID_ENCODER_INPUT')
        outputs = self.runtime.inference(inputs=[np.ascontiguousarray(features)], data_format=['nchw'])
        if outputs is None or len(outputs) != 1:
            raise RuntimeError('MOSS_INVALID_ENCODER_OUTPUT')
        output = np.asarray(outputs[0])
        if output.shape != (1, 375, 1024) or output.dtype != np.float32 or not np.isfinite(output).all():
            raise RuntimeError('MOSS_INVALID_ENCODER_OUTPUT')
        return np.ascontiguousarray(output[0, :chunk.valid_tokens])

    def close(self):
        if self.runtime is not None:
            self.runtime.release()
            self.runtime = None
