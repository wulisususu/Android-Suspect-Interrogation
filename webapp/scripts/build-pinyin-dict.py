# -*- coding: utf-8 -*-
"""生成离线拼音词典 webapp/public/pinyin-dict.json

数据源:
  - jieba 内置 dict.txt(词 + 词频)  -> 词候选(按词频排序)
  - pypinyin                        -> 拼音标注(词级 lazy_pinyin 带常见多音字校正)
输出结构:
  { "v": 1, "syllables": [...], "chars": {pinyin: [[汉字, 词频]...]}, "words": {pinyin: [[词, 词频]...]} }
规则:
  - 只保留 a-z(ü 归一为 v), 供无拼音基础用户直接按键
  - words: 全局 top WORD_TOP, 每个 key 最多 WORD_PER_KEY 个候选
  - chars: 每个 key 最多 CHAR_PER_KEY 个候选(含多音字读音)
"""
import json
import os
import re
from collections import defaultdict

import jieba
from pypinyin import lazy_pinyin, pinyin, Style

HERE = os.path.dirname(os.path.abspath(__file__))
OUT = os.path.normpath(os.path.join(HERE, "..", "public", "pinyin-dict.json"))

WORD_TOP = 60000        # 全局收录词数上限
WORD_PER_KEY = 24       # 单个拼音串最多词候选
CHAR_PER_KEY = 30       # 单个拼音最多字候选
WORD_MIN_LEN = 2
WORD_MAX_LEN = 6
FREQ_MIN = 200          # 丢弃超低频词

CJK_RE = re.compile(r"^[\u4e00-\u9fff]+$")
PY_RE = re.compile(r"^[a-z]+$")

dict_txt = os.path.join(os.path.dirname(jieba.__file__), "dict.txt")
entries = []  # (word, freq)
with open(dict_txt, encoding="utf-8") as f:
    for line in f:
        parts = line.rstrip("\n").split(" ")
        if len(parts) < 2:
            continue
        w, freq = parts[0], int(parts[1])
        entries.append((w, freq))
entries.sort(key=lambda x: -x[1])

def norm(syls):
    out = []
    for s in syls:
        s = s.lower().replace("ü", "v")
        if not PY_RE.match(s):
            return None
        out.append(s)
    return out

words = defaultdict(list)   # key -> [(word, freq)]
chars = defaultdict(list)   # key -> [(char, freq)]
word_count = 0

for w, freq in entries:
    if freq < FREQ_MIN:
        break
    if CJK_RE.match(w):
        if len(w) == 1:
            # 单字: 收录全部读音(多音字)
            for reading in pinyin(w, style=Style.NORMAL, heteronym=True)[0]:
                key = norm([reading])
                if key:
                    chars[key[0]].append((w, freq))
        else:
            if word_count >= WORD_TOP or not (WORD_MIN_LEN <= len(w) <= WORD_MAX_LEN):
                continue
            key = "".join(norm(lazy_pinyin(w)) or [])
            if not key:
                continue
            lst = words[key]
            if len(lst) < WORD_PER_KEY:
                lst.append((w, freq))
                word_count += 1
    if word_count >= WORD_TOP and len(chars) > 300:
        break

for key in chars:
    # 去重并截断
    seen, dedup = set(), []
    for ch, fr in sorted(chars[key], key=lambda x: -x[1]):
        if ch not in seen:
            seen.add(ch)
            dedup.append([ch, fr])
    chars[key] = dedup[:CHAR_PER_KEY]

for key in words:
    words[key] = [[w, fr] for w, fr in words[key]]

syllables = sorted(set(chars.keys()))
data = {
    "v": 1,
    "syllables": syllables,
    "chars": {k: chars[k] for k in sorted(chars)},
    "words": {k: words[k] for k in sorted(words)},
}
os.makedirs(os.path.dirname(OUT), exist_ok=True)
with open(OUT, "w", encoding="utf-8") as f:
    json.dump(data, f, ensure_ascii=False, separators=(",", ":"))

size_mb = os.path.getsize(OUT) / 1024 / 1024
print(f"words keys={len(data['words'])} chars keys={len(data['chars'])} "
      f"syllables={len(syllables)} size={size_mb:.2f}MB -> {OUT}")
# 自检
for probe in ("nihao", "ni", "hao", "zhongguo", "xian", "fa"):
    w = [x[0] for x in data["words"].get(probe, [])][:6]
    c = [x[0] for x in data["chars"].get(probe, [])][:6]
    print(f"  {probe}: words={w} chars={c}")
