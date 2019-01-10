{ pkgs ? import <nixpkgs> {} }:

{
  lib = import ./lib { inherit pkgs; }; # functions
  modules = import ./modules; # NixOS modules
  overlays = import ./overlays; # nixpkgs overlays

  dwdiff = pkgs.callPackage ./pkgs/tools/text/dwdiff { };
  ipscan = pkgs.callPackage ./pkgs/applications/networking/ipscan { };
  just = pkgs.callPackage ./pkgs/development/tools/build-managers/just {  };
  xcolor = pkgs.callPackage ./pkgs/applications/graphics/xcolor { };
  ydiff = pkgs.pythonPackages.callPackage ./pkgs/tools/text/ydiff { };
}
