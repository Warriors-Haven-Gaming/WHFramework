"""Compile the mod by switching between each branch.

Requires Git to run. Index and working directory must be clean.

After running this script, you can build the mod using HEMTT:
    /    $ cd mod
    /mod $ hemtt build

"""

import argparse
import shlex
import shutil
import subprocess
from pathlib import Path

BRANCH_DIRECTORIES = {
    "main": "Altis",
    "yulakia": "yulakia",
    "regero": "regero",
    "mogadishu": "Mog",
    "tanoa": "Tanoa",
    "colombia": "UMB_Colombia",
    "drakovac": "drakovac",
    "mehland": "mehland",
    "kaska": "kaska",
}

COMMON_FILES = {
    "LICENSE": "LICENSE",
    "README.md": "README.md",
    "stringtable.xml": "addons/main/stringtable.xml",
}


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument(
        "-b",
        "--branches",
        default=list(BRANCH_DIRECTORIES),
        help=f"The branches to build (default: {' '.join(BRANCH_DIRECTORIES)})",
        nargs="*",
    )

    args = parser.parse_args()
    branches: list[str] = args.branches

    check_call("git", "switch", "main")
    for branch in branches:
        suffix = BRANCH_DIRECTORIES[branch]
        check_valid_suffix(suffix)

    print("Copying common files...")
    copy_common_files(BRANCH_DIRECTORIES["main"])

    for branch in branches:
        suffix = BRANCH_DIRECTORIES[branch]
        copy_branch(branch, suffix)

    check_call("git", "switch", "main")


def check_valid_suffix(suffix: str) -> None:
    dest = Path(f"mod/addons/{suffix.lower()}/")
    if not dest.is_dir():
        raise RuntimeError(f"Missing addon directory: {dest}")


def copy_branch(branch: str, suffix: str) -> None:
    check_call("git", "switch", branch)
    path = Path(f"WHFramework.{suffix}")
    if not path.is_dir():
        raise RuntimeError(f"Missing mission directory: {path} ({branch})")

    dest = Path(f"mod/addons/{suffix.lower()}/WHFramework_{suffix}.{suffix}/")
    print(f"Copying to {dest}...")
    shutil.rmtree(dest, ignore_errors=True)
    shutil.copytree(path, dest)
    remove_common_files(dest)


def check_call(*args: object) -> None:
    str_args = [str(x) for x in args]
    print("$", shlex.join(str_args))
    subprocess.check_call(str_args, stdout=subprocess.DEVNULL)


def copy_common_files(suffix: str) -> None:
    for src, dest in COMMON_FILES.items():
        content = Path(f"WHFramework.{suffix}/").joinpath(src).read_bytes()
        Path("mod/").joinpath(dest).write_bytes(content)


def remove_common_files(root: Path) -> None:
    for src in COMMON_FILES:
        root.joinpath(src).unlink()


if __name__ == "__main__":
    main()
