# commit: chore: remove python build artifacts
from __future__ import annotations

import subprocess
from pathlib import Path

ignore_path = Path('.gitignore')
text = ignore_path.read_text(encoding='utf-8')
required = ['__pycache__/', '*.py[cod]']
for entry in required:
    if entry not in text.splitlines():
        if text and not text.endswith('\n'):
            text += '\n'
        text += entry + '\n'
ignore_path.write_text(text, encoding='utf-8')

tracked = subprocess.run(
    ['git', 'ls-files', '-z', '*.pyc', '*.pyo'],
    check=True,
    capture_output=True,
).stdout
paths = [item.decode('utf-8') for item in tracked.split(b'\0') if item]
if paths:
    subprocess.run(['git', 'rm', '-f', '--', *paths], check=True)
