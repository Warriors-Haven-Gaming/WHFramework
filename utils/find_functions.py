"""Count all uses of mission functions, optionally inside a function category."""
import argparse
import re
from collections import defaultdict
from pathlib import Path
from typing import Iterable, Iterator, NamedTuple

FUNCTION_PATTERN = re.compile(r"(?<!Function: )WHF_fnc_\w+")


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("-c", "--category", default="", help="A function category to scan")
    parser.add_argument("-m", "--most-common", action="store_true", help="Sort by most common functions")
    parser.add_argument("-v", "--verbose", action="count", default=0, help="Increase output verbosity")

    args = parser.parse_args()
    category: str = args.category
    most_common: bool = args.most_common
    verbose: int = args.verbose

    references = find_references(category)
    references = group_references(references)
    references = sort_grouped_references(references, most_common=most_common)

    total = sum(len(refs) for _, refs in references)
    print(f"{total:,} references found")

    for name, refs in references:
        print(f"{name} ({len(refs):,})")
        if verbose < 1:
            continue
        for ref in refs:
            print(f"    {ref.path}:{ref.lineno}:{ref.col}")


class Reference(NamedTuple):
    name: str
    path: Path
    lineno: int
    col: int


def find_references(category: str) -> Iterator[Reference]:
    mission_dir = next(Path().glob("WHFramework.*"))
    for script in mission_dir.joinpath(f"Functions/{category}").rglob("*.sqf"):
        content = script.read_text("utf8")

        for lineno, line in enumerate(content.splitlines(), start=1):
            for m in FUNCTION_PATTERN.finditer(line):
                col = m.start() + 1
                yield Reference(m[0], script, lineno, col)


def group_references(references: Iterable[Reference]) -> dict[str, list[Reference]]:
    grouped_references: dict[str, list[Reference]] = defaultdict(list)
    for reference in references:
        grouped_references[reference.name].append(reference)
    return grouped_references


def sort_grouped_references(
    grouped_references: dict[str, list[Reference]],
    *,
    most_common: bool = False,
) -> list[tuple[str, list[Reference]]]:
    references = sorted(grouped_references.items())
    if most_common:
        references.sort(key=lambda t: len(t[1]), reverse=True)
    return references


if __name__ == "__main__":
    main()
