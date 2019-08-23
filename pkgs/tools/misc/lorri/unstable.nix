{ callPackage, lib, fetchFromGitHub, ... } @ args:

let
  generic = import ./generic.nix;
  genericArgs = lib.attrNames (lib.functionArgs generic);
  oArgs = lib.filterAttrs (a: _: lib.elem a genericArgs) args;
in callPackage generic ({
  pname = "lorri-unstable";
  version = "2019-08-20";

  # master branch
  src = fetchFromGitHub {
    owner = "target";
    repo = "lorri";
    rev = "38eae3d487526ece9d1b8c9bb0d27fb45cf60816";
    sha256 = "11k9lxg9cv6dlxj4haydvw4dhcfyszwvx7jx9p24jadqsy9jmbj4";
  };

  cargoSha256 = "1daff4plh7hwclfp21hkx4fiflh9r80y2c7k2sd3zm4lmpy0jpfz";
} // oArgs)
