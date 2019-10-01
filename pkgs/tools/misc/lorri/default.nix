{ stdenv, rustPlatform, callPackage, fetchFromGitHub
, darwin ? null, direnv, nix, which
}:

let
  inherit (stdenv) lib;
in lib.makeOverridable (self: { result = rustPlatform.buildRustPackage rec {
  inherit (self) pname version;

  inherit (self) src;

  inherit (self) cargoSha256;

  buildInputs = [
    direnv
    nix
    which
  ] ++ lib.optionals stdenv.hostPlatform.isDarwin [
    darwin.cf-private
    darwin.security
    darwin.apple_sdk.frameworks.CoreServices
  ];

  doCheck = !stdenv.isDarwin;

  BUILD_REV_COUNT = src.revCount or 1;
  NIX_PATH = "nixpkgs=${src}/nix/bogus-nixpkgs";
  RUN_TIME_CLOSURE = callPackage "${src}/nix/runtime.nix" {};
  USER = "bogus";

  preConfigure = ''
    source ${src + "/nix/pre-check.sh"}

    # Do an immediate, light-weight test to ensure logged-evaluation
    # is valid, prior to doing expensive compilations.
    nix-build --show-trace ./src/logged-evaluation.nix \
      --arg src ./tests/integration/basic/shell.nix \
      --arg runTimeClosure "$RUN_TIME_CLOSURE" \
      --no-out-link
  '';

  meta = {
    description = "Your project's nix-env";
    longDescription = ''
      lorri is a nix-shell replacement for project development. lorri is based
      around fast direnv integration for robust CLI and editor integration.

      The project is about experimenting with and improving the developer's
      experience with Nix. A particular focus is managing your project's
      external dependencies, editor integration, and quick feedback.
    '';
    homepage = https://github.com/target/lorri;
    license = lib.licenses.asl20;
    maintainers = let m = lib.maintainers; in [ m.bb010g ];
    platforms = lib.platforms.unix;
  };
}; }) {
  pname = "lorri";
  version = "2019-08-20";

  # rolling-release branch
  src = fetchFromGitHub {
    owner = "target";
    repo = "lorri";
    rev = "38eae3d487526ece9d1b8c9bb0d27fb45cf60816";
    sha256 = "11k9lxg9cv6dlxj4haydvw4dhcfyszwvx7jx9p24jadqsy9jmbj4";
  };

  cargoSha256 = "1daff4plh7hwclfp21hkx4fiflh9r80y2c7k2sd3zm4lmpy0jpfz";
}
