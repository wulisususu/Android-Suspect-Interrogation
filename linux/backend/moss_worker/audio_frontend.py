"""PCM16 WAV and NumPy Whisper log-mel frontend for the verified MOSS export."""
from dataclasses import dataclass
import wave

import numpy as np


@dataclass(frozen=True)
class AudioChunk:
    features: np.ndarray
    valid_tokens: int


class AudioFrontend:
    def __init__(self, processor_config):
        feature = processor_config['feature_extractor']
        supported = dict(chunk_length=30, dither=0.0,
                         feature_extractor_type='WhisperFeatureExtractor', feature_size=80,
                         hop_length=160, n_fft=400, n_samples=480000, nb_max_frames=3000,
                         padding_side='right', padding_value=0.0, sampling_rate=16000)
        if any(feature.get(key) != value for key, value in supported.items()) or processor_config.get('audio_merge_size') != 4:
            raise ValueError('MOSS_PROCESSOR_CONFIG_UNSUPPORTED')
        self.feature = dict(feature)
        self.stride = feature['hop_length'] * 2 * processor_config['audio_merge_size']
        self.window = np.hanning(feature['n_fft'] + 1)[:-1]
        # Slaney's linear-below-1k/log-above-1k scale and area normalization.
        max_mel = 15 + np.log(8000 / 1000) / (np.log(6.4) / 27)
        mel = np.linspace(0, max_mel, feature['feature_size'] + 2)
        hz = mel * (200 / 3)
        logarithmic = mel >= 15
        hz[logarithmic] = 1000 * np.exp((np.log(6.4) / 27) * (mel[logarithmic] - 15))
        fft_hz = np.linspace(0, feature['sampling_rate'] / 2, feature['n_fft'] // 2 + 1)
        ramps = hz[:, None] - fft_hz[None, :]
        widths = np.diff(hz)
        self.mel_filters = np.maximum(0, np.minimum(-ramps[:-2] / widths[:-1, None],
                                                    ramps[2:] / widths[1:, None]))
        self.mel_filters *= (2 / (hz[2:] - hz[:-2]))[:, None]

    def read_samples(self, path, window=None):
        try:
            with wave.open(str(path), 'rb') as stream:
                if (stream.getnchannels(), stream.getsampwidth(), stream.getframerate(), stream.getcomptype()) != (1, 2, 16000, 'NONE'):
                    raise ValueError('MOSS_AUDIO_UNSUPPORTED_FORMAT')
                frames = stream.getnframes()
                if window is not None:
                    if (window.start_ms < 0 or window.end_ms <= window.start_ms
                            or window.end_ms > (frames + 15) // 16):
                        raise ValueError('MOSS_INVALID_AUDIO_WINDOW')
                    start = window.start_ms * 16
                    end = min(window.end_ms * 16, frames)
                    if start >= end:
                        raise ValueError('MOSS_INVALID_AUDIO_WINDOW')
                    stream.setpos(start)
                    frames = end - start
                data = stream.readframes(frames)
                if not frames or len(data) != frames * 2:
                    raise ValueError('MOSS_AUDIO_UNSUPPORTED_FORMAT')
        except (wave.Error, EOFError) as exc:
            raise ValueError('MOSS_AUDIO_UNSUPPORTED_FORMAT') from exc
        return np.frombuffer(data, dtype='<i2').astype(np.float32) / np.float32(32768)

    def log_mel(self, samples):
        padded = np.zeros(self.feature['n_samples'], dtype=np.float32)
        padded[:len(samples)] = samples
        padded = np.pad(padded, self.feature['n_fft'] // 2, mode='reflect')
        frames = np.lib.stride_tricks.sliding_window_view(padded, self.feature['n_fft'])[::self.feature['hop_length']][:-1]
        spectrum = np.fft.rfft(frames * self.window, axis=-1)
        power = (spectrum.real ** 2 + spectrum.imag ** 2).T
        log_spec = np.log10(np.maximum(self.mel_filters @ power, 1e-10))
        log_spec = np.maximum(log_spec, log_spec.max() - 8)
        return np.ascontiguousarray(((log_spec + 4) / 4)[None], dtype=np.float32)

    def chunks(self, path, window=None):
        samples = self.read_samples(path, window)
        for start in range(0, len(samples), self.feature['n_samples']):
            chunk = samples[start:start + self.feature['n_samples']]
            yield AudioChunk(self.log_mel(chunk), (len(chunk) + self.stride - 1) // self.stride)
