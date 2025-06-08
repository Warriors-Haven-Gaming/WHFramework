"""Normalize casing of class names in the vehicle catalog."""

import re
from pathlib import Path

PATTERN = re.compile(r'^    \["([^"]+?)"', re.MULTILINE)

mission_dir = next(Path().glob("WHFramework.*"))
catalog = mission_dir / "Functions" / "VehicleSpawner" / "fn_vehSpawnCatalog.sqf"
content = catalog.read_text("utf-8")
content = PATTERN.sub(lambda m: m[0].lower(), content)
content = catalog.write_text(content, "utf-8")
