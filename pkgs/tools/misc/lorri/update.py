#!/usr/bin/env nix-shell
#! nix-shell -i python3 -p common-updater-scripts nix nix-prefetch-github python3 python3Packages.lxml python3Packages.plumbum python3Packages.requests python3Packages.typing-extensions

# mypy: python-version=3

# mypy: disallow-incomplete-defs
# mypy: disallow-untyped-calls
# mypy: disallow-untyped-decorators
# mypy: disallow-untyped-defs
# mypy: no-implicit-optional
# mypy: strict-equality
# mypy: warn-redundant-casts
# mypy: warn-return-any
# mypy: warn-unreachable
# mypy: warn-unused-ignores

"""A Nixpkgs-style updater for lorri"""

import enum
import json
import logging
import pathlib
import subprocess
from typing import List
from typing import Optional
from typing import Tuple
from typing import Union

from plumbum import cli
from plumbum import local
import requests
from typing_extensions import Literal


LOGGER = logging.getLogger(__name__)
logger_verbosity = 0


def verbosity_to_logging_level(
    level: int
) -> Literal["CRITICAL", "ERROR", "WARNING", "INFO", "DEBUG", "NOTSET"]:
    if level >= 2:
        return "CRITICAL"
    elif level == 1:
        return "ERROR"
    elif level == 0:
        return "WARNING"
    elif level == -1:
        return "INFO"
    elif level == -2:
        return "DEBUG"
    else:
        return "NOTSET"


def set_verbosity(verbosity: Optional[int] = None):
    global logger_verbosity
    if verbosity is not None:
        logger_verbosity = verbosity
    LOGGER.setLevel(verbosity_to_logging_level(logger_verbosity))


def adjust_verbosity(d_verbosity: int) -> int:
    global logger_verbosity
    verbosity = logger_verbosity + d_verbosity
    set_verbosity(verbosity)
    return verbosity


class LorriUpdater(cli.Application):
    """Command line entry point"""

    @cli.switch(["-v", "--verbose"], help="Increase verbosity")
    def set_verbose(self, level: int):
        adjust_verbosity(level)

    @cli.switch(["-q", "--quiet"], help="Decrease verbosity")
    def set_quiet(self, level: int):
        adjust_verbosity(-level)

    def main(self):
        print("Hello world!")


@enum.unique
class HashAlgo(enum.Enum):
    MD5 = "md5"
    SHA1 = "sha1"
    SHA256 = "sha256"

    @classmethod
    def default(cls):
        return cls.SHA256


def nix_prefetch_github(
    owner, repo, rev: Optional[str] = None, prefetch: Optional[bool] = None
) -> Tuple[int, str, str]:
    flags: List[Union[bytes, str]] = []
    if rev is not None:
        flags.extend(("--rev", rev))
    if prefetch is not None:
        flags.append("--prefetch" if prefetch else "--no-prefetch")
    ret, stdout, stderr = local["nix-prefetch-github"].run([owner, repo, *flags])
    return ret, json.loads(stdout), stderr


def nix_prefetch_url(
    url,
    unpack: Optional[bool] = None,
    print_path: Optional[bool] = None,
    name: Optional[bytes] = None,
    hash_type: Optional[HashAlgo] = None,
) -> Tuple[int, str, str]:
    flags: List[Union[bytes, str]] = []
    if unpack is not None and unpack is True:
        flags.append("--unpack")
    if print_path is not None and print_path is True:
        flags.append("--print-path")
    if name is not None:
        flags.extend(("--name", name))
    if hash_type is not None:
        flags.extend(("--type", hash_type.value))
    return local["nix-prefetch-url"].run([url, *flags])


def update_source_version(
    pkg,
    version,
    new_source_hash: Optional[str] = None,
    new_source_url: Optional[str] = None,
    version_key: Optional[str] = None,
    system: Optional[str] = None,
    updated_file: Optional[str] = None,
):
    args: List[Union[bytes, str]] = []
    flags: List[Union[bytes, str]] = []
    if new_source_hash is not None:
        args.append(new_source_hash)
    if new_source_url is not None:
        args.append(new_source_url)
    if version_key is not None:
        flags.extend(("--version-key", version_key))
    if system is not None:
        flags.extend(("--system", system))
    if updated_file is not None:
        flags.extend(("--file", updated_file))
    pkgs_path = pathlib.Path(__file__).parent / "../../../../"
    return local["update-source-version"].run(
        [pkg, version, *args, *flags], cwd=pkgs_path
    )


if __name__ == "__main__":
    LorriUpdater.run()
