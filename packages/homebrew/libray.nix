{
  pkgs,
  ...
}: pkgs.python311Packages.buildPythonPackage rec {
  pname = "libray";
  version = "0.0.10";
  src = pkgs.fetchPypi {
    inherit pname version;
    hash = "sha256-a1wO8GOF8PIqmzFr5+s9Nh6sZHHpVxtGaFrbjwErUX8=";
  };

  doCheck = false;
  propagatedBuildInputs = with pkgs.python311Packages; [ pycryptodome html5lib tqdm beautifulsoup4 requests setuptools pip wheel urllib3 ];
}
