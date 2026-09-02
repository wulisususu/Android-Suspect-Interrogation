from __future__ import annotations

from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
TARGET = ROOT / "webapp/src/components/FormalTemplatePanel.vue"


def main() -> None:
    text = TARGET.read_text(encoding="utf-8")
    malformed = "    </article>\n  </section>\n<style scoped>"
    fixed = "    </article>\n  </section>\n</template>\n\n<style scoped>"
    trailing = "</style>\n</template>"
    if text.count(malformed) != 1:
        raise SystemExit(f"expected one malformed template/style boundary, found {text.count(malformed)}")
    if text.count(trailing) != 1:
        raise SystemExit(f"expected one trailing misplaced template close, found {text.count(trailing)}")
    if text.find(trailing) < text.find("<style scoped>"):
        raise SystemExit("misplaced template close must follow scoped style")
    text = text.replace(malformed, fixed, 1)
    text = text.replace(trailing, "</style>", 1)
    TARGET.write_text(text, encoding="utf-8")


if __name__ == "__main__":
    main()
