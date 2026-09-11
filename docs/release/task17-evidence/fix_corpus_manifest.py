import json
import sys

PATH = r"D:\police Android\task17\linux\backend\tests\fixtures\speaker_turn_corpus\speaker_corpus_manifest.json"
data = json.load(open(PATH, encoding="utf-8"))

tiers = {t["name"]: t for t in data["tiers"]}
dual = tiers["dual-qa-21"]
dual["durationMs"] = 182613
dual["sampleRate"] = 16000
dual["channels"] = 1
dual["derivation"] = ("ffmpeg -i '新錄音 21.m4a' -ac 1 -ar 16000 -acodec pcm_s16le "
                      "case-zhangming-16k.wav")

suspect = tiers["suspect-enroll-zhangming"]
suspect["derivedFrom"] = "dual-qa-21, GS02 turns concatenated by build_speaker_wav.py"
suspect["sha256"] = "25d6361ca581588f60d7a8dd8e4b91d930c5064becdf8b4321dc27d1cfb6797d"
suspect["durationMs"] = 30000
suspect["sampleRate"] = 16000
suspect["channels"] = 1
suspect["wav"] = "suspect-zhangming-only.wav"
suspect["derivation"] = ("python build_speaker_wav.py <segments.json> GS02 case-zhangming-16k.wav "
                         "suspect-zhangming-only.wav 30 250")
suspect["note"] = ("single-speaker excerpt used as the browser fake-mic input for enrollment. "
                   "The 185 s loop (sha256 6cf0eda1cfd27f31fa63d60269f3185f2fae835ba8caa8e13ffd7eaf710686d3) "
                   "is required when Chrome must keep feeding audio for a whole enrollment; "
                   "a 30 s file ends mid-capture and the browser channel closes.")

data["integrityNote"] = ("sha256 values are pinned per tier; audio is materialised out of band and never "
                         "committed. Verified 2026-09-11: dual-qa-21 matches the local 16 kHz derivation, "
                         "suspect tier has its own hash (the first revision wrongly reused the dual-qa hash).")

json.dump(data, open(PATH, "w", encoding="utf-8"), ensure_ascii=False, indent=1)
open(PATH, "a", encoding="utf-8").write("\n")

print("patched tiers:")
for t in data["tiers"]:
    print(" ", t["name"], "| sha:", (t.get("sha256") or "MISSING")[:16], "| wav:", t.get("wav", "-"))
