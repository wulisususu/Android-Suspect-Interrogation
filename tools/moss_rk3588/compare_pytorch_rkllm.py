"""Gate A: compare timestamped MOSS text from PyTorch and RKLLM."""
import argparse
from difflib import SequenceMatcher
import json
from pathlib import Path
import re
import unicodedata

STAMP = r'\[(\d+(?::\d{2}){0,2}(?:\.\d+)?)\]'
SEGMENT = re.compile(STAMP + r'\s*\[S(\d+)\]\s*(.*?)\s*' + STAMP, re.DOTALL)


def seconds(stamp):
    total = 0.0
    for part in stamp.split(':'):
        total = total * 60 + float(part)
    return total


def parse(text):
    segments = []
    for start, speaker, content, end in SEGMENT.findall(text):
        if seconds(end) > seconds(start) and content.strip():
            segments.append((speaker, content.strip()))
    return segments


def normalize(text):
    return ''.join(char for char in unicodedata.normalize('NFKC', text).casefold()
                   if unicodedata.category(char)[0] in ('L', 'N'))


def compare(reference, candidate):
    ref, actual = parse(reference), parse(candidate)
    ref_speakers = len({speaker for speaker, _ in ref})
    actual_speakers = len({speaker for speaker, _ in actual})
    similarity = SequenceMatcher(None, normalize(''.join(text for _, text in ref)),
                                 normalize(''.join(text for _, text in actual)), autojunk=False).ratio()
    passed = bool(ref and actual and ref_speakers >= 2 and actual_speakers >= 2
                  and abs(ref_speakers - actual_speakers) <= 1 and similarity >= .80)
    return {'passed': passed, 'normalized_character_similarity': similarity,
            'reference_segments': len(ref), 'candidate_segments': len(actual),
            'reference_speakers': ref_speakers, 'candidate_speakers': actual_speakers}


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--reference', type=Path, required=True)
    parser.add_argument('--candidate', type=Path, required=True)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    try:
        report = compare(args.reference.read_text(encoding='utf-8', errors='strict'),
                         args.candidate.read_text(encoding='utf-8', errors='strict'))
    except UnicodeError as error:
        report = {'passed': False, 'error': f'Invalid UTF-8: {error}'}
    args.output.write_text(json.dumps(report, indent=2), encoding='utf-8')
    print(json.dumps(report))
    raise SystemExit(0 if report['passed'] else 1)
