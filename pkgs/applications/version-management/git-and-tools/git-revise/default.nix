{ stdenv, buildPythonApplication, fetchPypi
}:

buildPythonApplication rec {
  pname = "git-revise";
  version = "0.4.2";

  src = fetchPypi {
    inherit pname version;
    sha256 = "1mq1fh8m6jxl052d811cgpl378hiq20a8zrhdjn0i3dqmxrcb8vs";
  };

  outputs = [ "out" "man" ];

  meta = let inherit (stdenv) lib; in {
    description = "Efficiently update, split, and rearrange git commits";
    homepage = https://github.com/mystor/git-revise;
    license = lib.licenses.mit;
    maintainers = let m = lib.maintainers; in [ m.bb010g ];
  };
}
