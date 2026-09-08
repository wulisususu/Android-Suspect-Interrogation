"""ctypes definitions transcribed from the verified RKLLM 1.3.0 rkllm.h.

Header SHA256: 80596a578f7f8e70df6eda1c2cbead3bfced14623a190258f2bd009a3d1f72cf.
All structures use the native aarch64 ABI, including the by-value perf record.
"""
import ctypes as C
from dataclasses import dataclass
from pathlib import Path

import numpy as np

from .context_budget import ContextBudget
from .runtime import sha256_file


class RKLLMExtendParam(C.Structure):
    _fields_ = [('base_domain_id', C.c_int32), ('embed_flash', C.c_int8),
                ('enabled_cpus_num', C.c_int8), ('enabled_cpus_mask', C.c_uint32),
                ('n_batch', C.c_uint8), ('use_cross_attn', C.c_int8), ('reserved', C.c_uint8 * 104)]


class RKLLMParam(C.Structure):
    _fields_ = [('model_path', C.c_char_p), ('max_context_len', C.c_int32),
                ('max_new_tokens', C.c_int32), ('top_k', C.c_int32), ('n_keep', C.c_int32),
                ('top_p', C.c_float), ('temperature', C.c_float), ('repeat_penalty', C.c_float),
                ('frequency_penalty', C.c_float), ('presence_penalty', C.c_float), ('mirostat', C.c_int32),
                ('mirostat_tau', C.c_float), ('mirostat_eta', C.c_float), ('skip_special_token', C.c_bool),
                ('ignore_eos_token', C.c_bool), ('is_async', C.c_bool), ('extend_param', RKLLMExtendParam)]


class RKLLMEmbedInput(C.Structure):
    _fields_ = [('embed', C.POINTER(C.c_float)), ('n_tokens', C.c_size_t)]


class RKLLMTokenInput(C.Structure):
    _fields_ = [('input_ids', C.POINTER(C.c_int32)), ('n_tokens', C.c_size_t)]


class RKLLMImageInput(C.Structure):
    _fields_ = [('image_embed', C.POINTER(C.c_float)), ('n_image_tokens', C.c_size_t), ('n_image', C.c_size_t),
                ('image_start', C.c_char_p), ('image_end', C.c_char_p), ('image_content', C.c_char_p),
                ('image_width', C.c_size_t), ('image_height', C.c_size_t)]


class RKLLMVideoInput(C.Structure):
    _fields_ = [('video_embed', C.POINTER(C.c_float)), ('n_frame_tokens', C.c_size_t),
                ('n_frame_per_video', C.c_size_t), ('n_video', C.c_size_t), ('video_start', C.c_char_p),
                ('video_end', C.c_char_p), ('video_content', C.c_char_p), ('frame_width', C.c_size_t),
                ('frame_height', C.c_size_t)]


class RKLLMMultiModalInput(C.Structure):
    _fields_ = [('prompt', C.c_char_p), ('image', RKLLMImageInput), ('video', RKLLMVideoInput)]


class RKLLMInputValue(C.Union):
    _fields_ = [('prompt_input', C.c_char_p), ('embed_input', RKLLMEmbedInput),
                ('token_input', RKLLMTokenInput), ('multimodal_input', RKLLMMultiModalInput)]


class RKLLMInput(C.Structure):
    _fields_ = [('role', C.c_char_p), ('enable_thinking', C.c_bool), ('input_type', C.c_int),
                ('value', RKLLMInputValue)]


class RKLLMInferParam(C.Structure):
    _fields_ = [('mode', C.c_int), ('lora_params', C.c_void_p), ('prompt_cache_params', C.c_void_p),
                ('sampling_params', C.c_void_p), ('keep_history', C.c_int), ('max_new_tokens', C.c_int32)]


class RKLLMResultLastHiddenLayer(C.Structure):
    _fields_ = [('hidden_states', C.POINTER(C.c_float)), ('embd_size', C.c_int), ('num_tokens', C.c_int)]


class RKLLMResultLogits(C.Structure):
    _fields_ = [('logits', C.POINTER(C.c_float)), ('vocab_size', C.c_int), ('num_tokens', C.c_int)]


class RKLLMPerfStat(C.Structure):
    _fields_ = [('prefill_time_ms', C.c_float), ('prefill_tokens', C.c_int),
                ('generate_time_ms', C.c_float), ('generate_tokens', C.c_int), ('memory_usage_mb', C.c_float)]


class RKLLMResult(C.Structure):
    _fields_ = [('text', C.c_char_p), ('token_id', C.c_int32), ('last_hidden_layer', RKLLMResultLastHiddenLayer),
                ('logits', RKLLMResultLogits), ('perf', RKLLMPerfStat)]


ResultCallback = C.CFUNCTYPE(C.c_int, C.POINTER(RKLLMResult), C.c_void_p, C.c_int)


class RKLLMCallback(C.Structure):
    _fields_ = [('result_callback', ResultCallback), ('result_userdata', C.c_void_p),
                ('tokenizer_callback', C.c_void_p), ('tokenizer_userdata', C.c_void_p),
                ('embed_callback', C.c_void_p), ('embed_userdata', C.c_void_p)]


@dataclass(frozen=True)
class Generation:
    text: str
    token_count: int | None
    normal_termination: bool
    perf: dict
    error: str | None = None


class RKLLMDecoder:
    def __init__(self, model, *, library, expected_sha256, eos_token_ids):
        selected = Path(library).resolve(strict=True)
        if sha256_file(selected) != expected_sha256:
            raise ValueError('MOSS_NATIVE_LIBRARY_HASH_MISMATCH')
        if C.sizeof(RKLLMInput) != 160 or C.sizeof(RKLLMParam) != 184:
            raise RuntimeError('MOSS_RKLLM_ABI_UNSUPPORTED')
        self.eos_ids = frozenset(eos_token_ids)
        if not self.eos_ids or any(type(token) is not int or token < 0 for token in self.eos_ids):
            raise ValueError('MOSS_INVALID_EOS_CONFIG')
        self.lib = C.CDLL(str(selected))
        if Path(self.lib._name).resolve() != selected or sha256_file(self.lib._name) != expected_sha256:
            raise RuntimeError('MOSS_NATIVE_LIBRARY_PATH_MISMATCH')
        signatures = {
            'rkllm_createDefaultParam': (RKLLMParam, []),
            'rkllm_init': (C.c_int, [C.POINTER(C.c_void_p), C.POINTER(RKLLMParam), C.POINTER(RKLLMCallback)]),
            'rkllm_run': (C.c_int, [C.c_void_p, C.POINTER(RKLLMInput), C.POINTER(RKLLMInferParam), C.c_void_p]),
            'rkllm_destroy': (C.c_int, [C.c_void_p]), 'rkllm_abort': (C.c_int, [C.c_void_p]),
            'rkllm_set_chat_template': (C.c_int, [C.c_void_p, C.c_char_p, C.c_char_p, C.c_char_p]),
            'rkllm_clear_kv_cache': (C.c_int, [C.c_void_p, C.c_int, C.POINTER(C.c_int), C.POINTER(C.c_int)]),
        }
        for name, (restype, argtypes) in signatures.items():
            function = getattr(self.lib, name)
            function.restype, function.argtypes = restype, argtypes
        self.handle = C.c_void_p()
        self._tokens, self._bytes, self._perf = [], bytearray(), {}
        self._finished, self._error = False, None
        self._callback = ResultCallback(self._receive)
        self._callbacks = RKLLMCallback(result_callback=self._callback)
        self._model_path = str(model).encode('utf-8')
        params = self.lib.rkllm_createDefaultParam()
        params.model_path = self._model_path
        params.max_context_len, params.max_new_tokens = 16384, 5120
        params.top_k, params.top_p, params.temperature = 1, 1, 1
        params.repeat_penalty, params.frequency_penalty, params.presence_penalty, params.mirostat = 1, 0, 0, 0
        params.skip_special_token, params.ignore_eos_token, params.is_async = True, False, False
        code = self.lib.rkllm_init(C.byref(self.handle), C.byref(params), C.byref(self._callbacks))
        if code != 0:
            self.close()
            raise RuntimeError(f'MOSS_RKLLM_INIT_FAILED:{code}')
        code = self.lib.rkllm_set_chat_template(self.handle, b'', b'', b'')
        if code != 0:
            self.close()
            raise RuntimeError(f'MOSS_RKLLM_TEMPLATE_FAILED:{code}')

    def _receive(self, pointer, userdata, state):
        try:
            if state in (0, 1):
                if not pointer or self._finished:
                    self._error = 'MOSS_RKLLM_INVALID_CALLBACK'
                else:
                    result = pointer.contents
                    self._tokens.append(result.token_id)
                    if result.text:
                        self._bytes.extend(result.text)
            elif state == 2:
                self._finished = True
                if pointer:
                    self._perf = {name: getattr(pointer.contents.perf, name) for name, _ in RKLLMPerfStat._fields_}
            else:
                self._error = 'MOSS_RKLLM_CALLBACK_ERROR'
        except Exception:
            # Never let a Python exception escape through the C callback boundary.
            self._error = 'MOSS_RKLLM_CALLBACK_ERROR'
        return 0

    def decode(self, embeds):
        values = np.asarray(embeds)
        if (values.ndim != 2 or values.shape[1] != 1024 or values.dtype != np.float32
                or not len(values) or not np.isfinite(values).all()):
            raise ValueError('MOSS_INVALID_EMBEDDINGS')
        if not ContextBudget().fits(len(values)):
            raise ValueError('MOSS_CONTEXT_BUDGET_EXCEEDED')
        values = np.ascontiguousarray(values)
        self._tokens, self._bytes, self._perf = [], bytearray(), {}
        self._finished, self._error = False, None
        # keep_history=0 alone still reuses a shared prompt prefix in SDK 1.3.
        # Explicitly clear all KV positions before every independent window.
        code = self.lib.rkllm_clear_kv_cache(self.handle, 0, None, None)
        if code != 0:
            return Generation('', None, False, {}, f'MOSS_RKLLM_CLEAR_CACHE_FAILED:{code}')
        inputs = RKLLMInput(role=b'user', enable_thinking=False, input_type=2)
        inputs.value.embed_input = RKLLMEmbedInput(values.ctypes.data_as(C.POINTER(C.c_float)), len(values))
        params = RKLLMInferParam(mode=0, keep_history=0, max_new_tokens=5120)
        code = self.lib.rkllm_run(self.handle, C.byref(inputs), C.byref(params), None)
        if code != 0:
            self._error = f'MOSS_RKLLM_RUN_FAILED:{code}'
        try:
            text = self._bytes.decode('utf-8')
        except UnicodeDecodeError:
            text = self._bytes.decode('utf-8', errors='replace')
            self._error = self._error or 'MOSS_RKLLM_INVALID_UTF8'
        # Board probes show one NORMAL/WAITING event per generated token and
        # perf.generate_tokens == events - 1, with or without EOS. FINISH has
        # token_id=0; it is not a token and does not prove normal termination.
        metadata_valid = (bool(self._tokens) and all(token >= 0 for token in self._tokens)
                          and self._perf.get('generate_tokens') == len(self._tokens) - 1
                          and self._perf.get('prefill_tokens') == len(values)
                          and all(np.isfinite(value) and value >= 0 for value in self._perf.values()))
        normal = bool(not self._error and self._finished and metadata_valid and self._tokens[-1] in self.eos_ids)
        return Generation(text, len(self._tokens) if self._tokens else None, normal, self._perf, self._error)

    def close(self):
        if self.handle:
            self.lib.rkllm_destroy(self.handle)
            self.handle = C.c_void_p()
