{ stdenv, buildPackages, fetchFromGitHub
, oniguruma
, valgrind, which
}:

stdenv.mkDerivation rec {
  pname = "jq-dlopen-unstable";
  version = "2019-07-09";

  src = fetchFromGitHub {
    owner = "nicowilliams";
    repo = "jq";
    # dlopen branch, stedolan/jq#1843
    rev = "46b9d612af9e3822c43a70978c1d64b49a42bd07";
    sha256 = "10b022533qs15a8cvx6w64shl0n80mp2v14j29l6kinw7v4d0hgn";
  };

  outputs = [ "bin" "doc" "man" "dev" "lib" "out" ];

  nativeBuildInputs = [
    buildPackages.autoreconfHook
  ];
  buildInputs = [
    oniguruma
  ];
  installCheckInputs = [
    valgrind
    which
  ];

  postPatch = let
    # from ./docs/Pipfile
    docsPython = buildPackages.python3.withPackages (ps: [
      ps.jinja2
      ps.lxml
      ps.markdown
      ps.pyyaml_3 or ps.pyyaml
    ]);
  in ''
    substituteInPlace Makefile.am \
      --replace 'pipenv run python' ${docsPython}/bin/python

    printf "%s\n" "echo ''${version@E}" > scripts/version

    sed -i '/m4_define(\[jq_version\],/{N;N;N;s/.*/m4_define([jq_version], ['"$version"'])/}' \
      configure.ac
  '';

  configureFlags = [
    "--bindir=\${bin}/bin"
    "--sbindir=\${bin}/bin"
    "--datadir=\${doc}/share"
    "--mandir=\${man}/share/man"
  ] ++
    # jq is linked to libjq:
    stdenv.lib.optional (!stdenv.isDarwin) "LDFLAGS=-Wl,-rpath,\\\${libdir}";

  # jq is broken on dlopen
  doInstallCheck = false;
  installCheckTarget = "check";

  postInstallCheck = ''
    $bin/bin/jq --help >/dev/null
  '';

  meta = let inherit (stdenv) lib; in {
    description = ''A lightweight and flexible command-line JSON processor'';
    downloadPage = https://stedolan.github.io/jq/download/;
    homepage = https://stedolan.github.io/jq/;
    license = lib.licenses.mit;
    maintainers = let m = lib.maintainers; in [ m.raskin m.globin m.bb010g ];
    platforms = let p = lib.platforms; in p.linux ++ p.darwin;
    updateWalker = true;
  };
}

