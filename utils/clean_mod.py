import shutil
from pathlib import Path

for addon in Path("mod/addons").iterdir():
    mission = next(addon.glob("WHFramework_*.*"), None)
    if mission is None:
        continue

    print(mission)
    shutil.rmtree(mission)
