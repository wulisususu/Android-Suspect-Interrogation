"""Build the RKLLM 1.3.0 external-embedding calibration dataset offline."""
import argparse
import json
import pickle
from pathlib import Path

import numpy as np
import torch


def build_calibration_set(sources, output):
    output = Path(output)
    if output.exists() and any(output.iterdir()):
        raise FileExistsError(f'Calibration output is not empty: {output}')
    arrays = []
    for source in sources:
        array = np.load(source, allow_pickle=False)
        if (array.ndim != 3 or array.shape[0] != 1 or array.shape[1] < 1
                or array.shape[2] != 1024 or array.dtype.kind != 'f'
                or not np.isfinite(array).all()):
            raise ValueError('Captured embeddings must be finite floating point [1, tokens, 1024]')
        array = np.ascontiguousarray(array, dtype=np.float32)
        if not np.isfinite(array).all():
            raise ValueError('Captured embeddings overflow float32')
        arrays.append(array)
    if not arrays:
        raise ValueError('At least one captured array is required')
    output.mkdir(parents=True, exist_ok=True)
    entries = []
    for index, array in enumerate(arrays):
        name = f'sample_{index:04d}.pkl'
        with (output / name).open('wb') as stream:
            pickle.dump({'inputs_embeds': torch.from_numpy(array)}, stream)
        entries.append({'sample': name, 'token_nums': array.shape[1]})
    dataset = output / 'inputs.json'
    dataset.write_text(json.dumps(entries, indent=2), encoding='utf-8')
    return dataset


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--input', type=Path, action='append', required=True)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    print(build_calibration_set(args.input, args.output))
