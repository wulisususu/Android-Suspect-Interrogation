from __future__ import annotations

from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
TARGET = ROOT / "webapp/src/components/FormalTemplatePanel.vue"


def main() -> None:
    text = TARGET.read_text(encoding="utf-8")
    malformed = "    </article>\n  </section>\n<style scoped>"
    fixed = "    </article>\n  </section>\n</template>\n\n<style scoped>"
    if text.count(malformed) != 1:
        raise SystemExit(f"expected one malformed template/style boundary, found {text.count(malformed)}")
    if not text.endswith("</style>\n</template>"):
        raise SystemExit("expected trailing </style> followed by misplaced </template>")
    text = text.replace(malformed, fixed, 1)
    text = text.removesuffix("</style>\n</template>") + "</style>\n"
    TARGET.write_text(text, encoding="utf-8")


if __name__ == "__main__":
    main()
