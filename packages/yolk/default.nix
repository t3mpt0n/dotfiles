{
	lib,
	buildPythonPackage,
	fetchPypi,
	setuptools,
	pythonOlder
}: buildPythonPackage rec {
	pname = "yolk";
	version = "0.4.3";
	format = "pyproject";
	disabled = pythonOlder "2.5";

	src = fetchPypi {
		inherit pname version;
		sha256 = lib.fakeSha256;
	};
	doCheck = false;
	propagatedBuildInputs = [ setuptools ];

	meta = with lib; {
		description = "Command-line tool for querying PyPI and Python packages installed on your system";
		homepage = "https://pypi.org/project/yolk/";
		license = licenses.bsd3;
		platforms = platforms.linux;
		maintainers = with maintainers; [ t3mpt0n ];
	};
}
