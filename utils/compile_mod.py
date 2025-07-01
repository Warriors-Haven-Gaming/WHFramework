"""Compile the mod by switching between each branch.

Requires Git to run. Index and working directory must be clean.

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


def check_call(*args: object) -> None:
    str_args = [str(x) for x in args]
    print("$", shlex.join(str_args))
    subprocess.check_call(str_args, stdout=subprocess.DEVNULL)


if __name__ == "__main__":
    main()
