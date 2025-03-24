"""Extract a list of all class names in the vehicle catalog.

Useful for pasting into the debug console to validate that all class names exist:

private _vehicles = [];
_vehicles select {!isClass (configFile >> "CfgVehicles" >> _x)}

"""

import json
import re
from pathlib import Path

PATTERN = re.compile(r'^    \["([^"]+?)"', re.MULTILINE)

mission_dir = next(Path().glob("WHFramework.*"))
catalog = mission_dir / "Functions" / "VehicleSpawner" / "fn_vehSpawnCatalog.sqf"
with catalog.open(encoding="utf-8") as f:
    content = f.read()

strings = sorted({m[1] for m in PATTERN.finditer(content)})
print(json.dumps(strings))
