"""Build mission files from the given repository branches.

Requires Git to run. Index and working directory must be clean.

"""

import argparse
import contextlib
import shlex
import shutil
import subprocess
import tempfile
from pathlib import Path
from typing import Iterable, Iterator

# FIXME: avoid hardcoding addon builder path
ADDON_BUILDER = Path("C:/Program Files (x86)/Steam/steamapps/common/Arma 3 Tools/AddonBuilder/AddonBuilder.exe")
DESTINATION = Path("build")
DEFAULT_BRANCHES = ("main", "mogadishu", "regero", "tanoa", "yulakia")


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument(
        "-b",
        "--branches",
        default=list(DEFAULT_BRANCHES),
        help=f"The branches to build (default: {' '.join(DEFAULT_BRANCHES)})",
        nargs="*",
    )
    parser.add_argument(
        "-c",
        "--clear-temp",
        action="store_true",
        help="Clear temporary directories used by Addon Builder",
    )
    parser.add_argument(
        "-d",
        "--dest",
        default=DESTINATION,
        help=f"The destination directory (default: %(default)s)",
        type=Path,
    )
    parser.add_argument(
        "--dry-run",
        action="store_true",
        help="Print the commands to run instead of actually running them",
    )

    args = parser.parse_args()
    branches: list[str] = args.branches
    clear_temp: bool = args.clear_temp
    dest: Path = args.dest
    dry_run: bool = args.dry_run

    dest = dest.resolve()
    dest.mkdir(exist_ok=True)

    with contextlib.suppress(subprocess.CalledProcessError, AddonBuilderError):
        for branch in branches:
            build_branch(branch, dest, clear_temp=clear_temp, dry_run=dry_run)


def build_branch(
    branch: str,
    dest_dir: Path,
    *,
    clear_temp: bool,
    dry_run: bool,
) -> None:
    check_call("git", "switch", branch, dry_run=dry_run)
    for path in find_mission_directories():
        build_mission(path, dest_dir, clear_temp=clear_temp, dry_run=dry_run)


def find_mission_directories() -> Iterable[Path]:
    return (p for p in Path().resolve().glob("WHFramework.*") if p.is_dir())


def build_mission(
    src_dir: Path,
    dest_dir: Path,
    *,
    clear_temp: bool,
    dry_run: bool,
) -> None:
    if clear_temp:
        clear_temp_build(src_dir, dry_run=dry_run)

    with temp_patterns_file("*") as includes:
        check_addon_builder_output(
            ADDON_BUILDER,
            str(src_dir),
            str(dest_dir),
            f"-include={shlex.quote(includes.name)}",
            dry_run=dry_run,
        )

    if clear_temp:
        clear_temp_build(src_dir, dry_run=dry_run)


@contextlib.contextmanager
def temp_patterns_file(*patterns: str) -> Iterator[Path]:
    path = Path("includes.txt").resolve()
    with path.open("x") as f:
        f.write(";".join(patterns) + "\n")

    try:
        yield path
    finally:
        path.unlink()


def check_call(*args: object, dry_run: bool) -> None:
    str_args = [str(x) for x in args]
    print("$", shlex.join(str_args))
    if not dry_run:
        subprocess.check_call(str_args, stdout=subprocess.DEVNULL)


def check_output(*args: object, dry_run: bool) -> str | None:
    str_args = [str(x) for x in args]
    print("$", shlex.join(str_args))
    if not dry_run:
        return subprocess.check_output(str_args, text=True)


def check_addon_builder_output(*args: object, dry_run: bool) -> str | None:
    str_args = [str(x) for x in args]
    print("$", shlex.join(str_args))
    if dry_run:
        return

    out = subprocess.check_output(str_args, text=True)
    print(out)
    for line in out.splitlines():
        error_index = line.find("[ERROR]: ")
        if error_index >= 0:
            raise AddonBuilderError(line[error_index + 9 :])

    return out


def clear_temp_build(src_dir: Path, *, dry_run: bool) -> None:
    temp_dir = Path(tempfile.gettempdir()) / src_dir.name
    print(f"$ rm -rf {temp_dir}")
    if dry_run or not temp_dir.is_dir():
        return
    shutil.rmtree(temp_dir)


class AddonBuilderError(Exception): ...


if __name__ == "__main__":
    main()
