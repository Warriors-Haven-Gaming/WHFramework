"""Validates SQF function names in docstrings."""
import argparse
import re
import sys
from pathlib import Path

TAG = "WHF"
FUNCTION_PATTERN = re.compile(r'^Function: (.+)$', re.MULTILINE)


def transform_function_name(tag: str, filename: str) -> str:
    name = filename.removeprefix("fn_")
    return f"{tag}_fnc_{name}"


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument(
        "-v",
        "--verbose",
        action="count",
        default=0,
        help="Increase output verbosity",
    )
    args = parser.parse_args()

    passed = True
    for path in Path().glob("WHFramework.*/**/fn_*.sqf"):
        name = str(path)
        content = path.read_text("utf-8")

        m = FUNCTION_PATTERN.search(content)
        if m is None:
            print(f"{name}: No function name found")
            passed = False
            continue

        expected_name = transform_function_name(TAG, path.stem)
        if m[1] != expected_name:
            print(f'{name}: Unexpected function name "{m[1]}"')
            passed = False
            continue

        if args.verbose > 0:
            print(name)

    return not passed


if __name__ == "__main__":
    sys.exit(main())
