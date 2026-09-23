# -*- coding: utf-8 -*-
"""生成离线拼音词典 webapp/public/pinyin-dict.json

数据源:
  - jieba 内置 dict.txt(词 + 词频)  -> 词候选(按词频排序)
  - pypinyin                        -> 拼音标注(词级 lazy_pinyin 带常见多音字校正)
输出结构:
  { "v": 2, "syllables": [...],
    "chars": {pinyin: [[汉字, 词频]...]},
    "words": {全拼串: [[词, 词频]...]},
    "abbr":  {声母缩写串: [[词, 词频]...]} }   # 简拼: 你好(nihao) -> "nh"
规则:
  - 只保留 a-z(ü 归一为 v), 供无拼音基础用户直接按键
  - words: 全局 top WORD_TOP, 每个 key 最多 WORD_PER_KEY 个候选
  - abbr:  每个缩写 key 最多 ABBR_PER_KEY 个候选(条目按词频序遍历,天然高频优先)
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
WORD_PER_KEY = 24       # 单个全拼串最多词候选
ABBR_PER_KEY = 40       # 单个简拼串最多词候选
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

words = defaultdict(list)   # 全拼 key -> [(word, freq)]
abbr = defaultdict(list)    # 简拼 key -> [(word, freq)]
chars = defaultdict(list)   # 拼音 key -> [(char, freq)]
char_freq = defaultdict(int)  # 单字 -> 原始词频(取最大), 供简拼加权
word_count = 0

for w, freq in entries:
    if freq < FREQ_MIN:
        break
    if not CJK_RE.match(w):
        continue
    if len(w) == 1:
        # 单字: 收录全部读音(多音字)
        char_freq[w] = max(char_freq[w], freq)
        for reading in pinyin(w, style=Style.NORMAL, heteronym=True)[0]:
            key = norm([reading])
            if key:
                chars[key[0]].append((w, freq))
        continue
    if word_count >= WORD_TOP or not (WORD_MIN_LEN <= len(w) <= WORD_MAX_LEN):
        continue
    syls = norm(lazy_pinyin(w))
    if not syls:
        continue
    key = "".join(syls)
    lst = words[key]
    if len(lst) < WORD_PER_KEY:
        lst.append((w, freq))
        word_count += 1
        # 简拼: 每个音节的首字母(≥2 个音节才有意义)
        if len(syls) >= 2:
            akey = "".join(s[0] for s in syls)
            if len(abbr[akey]) < ABBR_PER_KEY:
                abbr[akey].append((w, freq))
    if word_count >= WORD_TOP and len(chars) > 300:
        break

for key in chars:
    seen, dedup = set(), []
    for ch, fr in sorted(chars[key], key=lambda x: -x[1]):
        if ch not in seen:
            seen.add(ch)
            dedup.append([ch, fr])
    chars[key] = dedup[:CHAR_PER_KEY]

# 简拼重排: 候选按 词频 × 字频几何均值 加权,让"你好"这类常用字组合排到
# 低频字生僻词(南海/浓厚)前面。jieba 原始词频对话语常用词(你好 725 < 南海 2087)
# 的排序不符合输入法直觉。
import math

def abbr_score(word: str, freq: int) -> float:
    geo = 1.0
    for ch in word:
        geo *= char_freq.get(ch, 1000)
    return freq * (geo ** (1.0 / max(1, len(word))))

for key in abbr:
    abbr[key] = sorted(abbr[key], key=lambda x: -abbr_score(x[0], x[1]))

syllables = sorted(set(chars.keys()))
data = {
    "v": 2,
    "syllables": syllables,
    "chars": {k: chars[k] for k in sorted(chars)},
    "words": {k: words[k] for k in sorted(words)},
    "abbr": {k: abbr[k] for k in sorted(abbr)},
}
os.makedirs(os.path.dirname(OUT), exist_ok=True)
with open(OUT, "w", encoding="utf-8") as f:
    json.dump(data, f, ensure_ascii=False, separators=(",", ":"))

size_mb = os.path.getsize(OUT) / 1024 / 1024
print(f"words keys={len(data['words'])} abbr keys={len(data['abbr'])} "
      f"chars keys={len(data['chars'])} syllables={len(syllables)} "
      f"size={size_mb:.2f}MB -> {OUT}")
# 自检: 全拼与简拼
for probe in ("nihao", "nh", "zhongguo", "zg", "bj", "xian"):
    w = [x[0] for x in data["words"].get(probe, [])][:6]
    a = [x[0] for x in data["abbr"].get(probe, [])][:6]
    c = [x[0] for x in data["chars"].get(probe, [])][:6]
    print(f"  {probe}: words={w} abbr={a} chars={c}")
