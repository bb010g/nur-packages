{ lib, libSuper }:

let
  # lib imports {{{1
  inherit (builtins) #{{{2
    isAttrs
  ;
  inherit (lib.trivial) #{{{1
    apply applyOp # (mod)
    comp compOp flow # (mod)
    comp2 comp2Op flow2 # (mod)
    comp3 comp3Op flow3 # (mod)
    flip
    functionArgs
    hideFunctionArgs # (mod)
    id
    isFunction
    mapFunctionArgs # (mod)
    mapIf # (mod)
    setFunctionArgs
  ; #}}}1
in {

  # apply [applyOp] {{{2
  apply = id;

  # applyOp {{{3
  applyOp = flip apply;

  # comp [compOp flow] {{{2
  /* Compose two functions, with data from the second supplying the first.

     Type: comp :: (b -> c) -> (a -> b) -> a -> c

     Example:
       comp (x: x*3) (x: x-1) 2
       => 3
       comp (x: x-1) (x: x*3) 2
       => 5
  */
  comp =
    # Second function to apply
    g:
    # First function to apply
    f:
    # Argument to supply
    x:
    g (f x);

  # compOp {{{3
  compOp = flip comp;

  # flow {{{3
  flow = compOp;

  # comp2 [comp2Op flow2] {{{2
  comp2 = comp comp comp;

  # comp2Op {{{3
  comp2Op = flip comp2;

  # flow2 {{{3
  flow2 = comp2Op;

  # comp3 [comp3Op flow3] {{{2
  comp3 = comp comp comp2;

  # comp3Op {{{3
  comp3Op = flip comp3;

  # flow3 {{{3
  flow3 = comp3Op;

  # hideFunctionArgs {{{2
  hideFunctionArgs =
    names:
    f:
    let self = f // {
      __functor = super: args: self.__functor self (removeAttrs
      (builtins.trace (builtins.attrNames args) args) names);
    }; in self;

  # mapFunctionArgs {{{2
  mapFunctionArgs =
    f:
    fun:
    if isAttrs fun
      then fun // { __functionArgs = f (functionArgs fun); }
      else setFunctionArgs fun (f (builtins.functionArgs fun));

  # mapIf {{{2
  /* Apply function if the second argument is true.

     Type: mapIf :: (a -> a) -> bool -> a -> a

     Example:
       mapIf (x: x+1) false 9
       => 9
       mapIf (x: x+1) true 9
       => 10
  */
  mapIf =
    # Function to call
    f:
    # Boolean to test
    b:
    if b then f else id;

  #}}}1

}
# vim:fdm=marker:fdl=1