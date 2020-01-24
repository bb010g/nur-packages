lib: libSuper:

let
  inherit (builtins) isAttrs mapAttrs typeOf;
  mergeConst = merge: x: y:
    y;
  mergeAttrs = merge: x: y:
    x // (mapAttrs (n: yV: if x ? ${n} then merge x.${n} yV else yV) y);
  merge' = merge: x: y:
    let xTy = typeOf x; yTy = typeOf y; in
    if xTy != yTy
      then merge x y
    else if xTy == "set"
      then mergeAttrs merge x y
    else
      merge x y;
  merge_0 = mergeConst merge_0;
  merge_1 = merge' merge_0;
  merge_2 = merge' merge_1;
  libMerged = merge_2 libSuper lib;
  callLib = file: import file libMerged libSuper;
in let exports = {

  ## modules

  attrsets = callLib ./attrsets.nix;
  # edn = import ./edn;
  fixedPoints = callLib ./fixed-points.nix;
  lists = callLib ./lists.nix;
  trivial = callLib ./trivial.nix;
  # utf8 = import ./utf-8;

  ## top-level

  inherit (lib.attrsets)
    mapAttr
    mapAttr'
    mapAttrOr mapAttrOrElse
    mapOptionalAttr
  ;

  inherit (lib.fixedPoints)
    composeExtensionList
  ;

  inherit (lib.lists)
    foldl1'
  ;

  inherit (lib.trivial)
    apply applyOp
    comp compOp flow
    comp2 comp2Op flow2
    comp3 comp3Op flow3
    hideFunctionArgs
    mapFunctionArgs
    mapIf
  ;

}; in exports
