"""Extract a list of commands and function names used with remoteExec(Call)."""

import re
from pathlib import Path

PATTERN = re.compile(r'remoteExec(?:Call)? \["(\w+)"', re.MULTILINE)

matches: list[re.Match[str]] = []
mission_dir = next(Path().glob("WHFramework.*"))
for path in mission_dir.rglob("*.sqf"):
    with path.open(encoding="utf-8") as f:
        matches.extend(PATTERN.finditer(f.read()))

functions = sorted({m[1] for m in matches})
for function in functions:
    print(function)
