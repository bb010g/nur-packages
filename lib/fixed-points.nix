{ lib, libSuper }:

let
  # lib imports {{{1
  inherit (lib.lists) #{{{2
    foldl1'
  ;
  inherit (lib.fixedPoints) #{{{1
    composeExtensions
    composeExtensionList # (mod)
  ; #}}}1
in {

  # composeExtensionList {{{2
  composeExtensionList =
    fs:
    if fs == [ ]
      then (self: super: { })
      else foldl1' composeExtensions fs;

  #}}}1

}
# vim:fdm=marker:fdl=1
