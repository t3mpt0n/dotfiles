{
  lib,
  buildPythonPackage,
  fetchPypi,
  pythonOlder,
  setuptools
}: buildPythonPackage rec {
  pname = "simple-term-menu";
  version = "1.6.4";
  format = "pyproject";
  disabled = pythonOlder "3.5";

  src = fetchPypi {
    inherit pname version;
    sha256 = "sha256-vpxdvY3xKkBLFM2Oldb8AtWMYOJVX2Xd3kF3fEh/s7k=";
  };
  propagatedBuildInputs = [ setuptools ];

  meta = with lib; {
    description = "A Python package which creates simple interactive menus on the command line.";
    homepage = "https://github.com/IngoMeyer441/simple-term-menu";
    license = licenses.mit;
    platforms = platforms.linux;
    maintainers = with maintainers; [ t3mpt0n ];
  };
}
