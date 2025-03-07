"""Validates the existence of localization keys in stringtable.xml."""

import re
import sys
from pathlib import Path
from typing import Iterable


def find_mission_directories() -> Iterable[Path]:
    for path in Path().iterdir():
        if not path.is_dir():
            continue
        if not path.name.startswith("WHFramework."):
            continue
        yield path


def extract_stringtable_keys(content: str) -> set[str]:
    return set(m[1] for m in re.finditer(r'ID="([^"]+)"', content))


def find_used_keys(root: Path) -> set[str]:
    keys: set[str] = set()

    paths = [root / "description.ext", *root.rglob("*.sqf")]
    for path in paths:
        content = path.read_text("utf-8")
        for m in re.finditer(r'"\$?(STR_WHF_[^"]+)"', content):
            keys.add(m[1])

    return keys


def main() -> int:
    passed = True
    for root in find_mission_directories():
        stringtable = root / "stringtable.xml"
        if not stringtable.is_file():
            continue

        print(root)

        stringtable_keys = extract_stringtable_keys(stringtable.read_text("utf-8"))
        used_keys = find_used_keys(root)

        missing = used_keys - stringtable_keys
        unused = stringtable_keys - used_keys

        if missing:
            passed = False
            print("Missing keys:")
            for key in sorted(missing):
                print("   ", key)

        if unused:
            passed = False
            print("Unused keys:")
            for key in sorted(unused):
                print("   ", key)

    return passed


if __name__ == "__main__":
    sys.exit(main())
