{ callPackage, lib, fetchFromGitHub, ... } @ args:

let
  generic = import ./generic.nix;
  genericArgs = lib.attrNames (lib.functionArgs generic);
  oArgs = lib.filterAttrs (a: _: lib.elem a genericArgs) args;
in callPackage generic ({
  pname = "lorri-unstable";
  version = "2019-07-01";

  # master branch
  src = fetchFromGitHub {
    owner = "target";
    repo = "lorri";
    rev = "d3e452ebc2b24ab86aec18af44c8217b2e469b2a";
    sha256 = "07yf3gl9sixh7acxayq4q8h7z4q8a66412z0r49sr69yxb7b4q89";
  };

  cargoSha256 = "094w2lp6jvxs8j59cjqp6b3kg4y4crlnqka5v2wmq4j0mn6hvhsj";
} // oArgs)
