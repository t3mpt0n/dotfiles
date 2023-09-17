{
	lib,
	buildPythonPackage,
	fetchFromGitHub,
	pythonOlder,
	poetry-core,
	deezer-py,
	click,
	pycryptodomex,
	mutagen,
	pathvalidate,
	tqdm,
	aiofiles,
	aiohttp,
	tomlkit,
	requests,
	aiodns,
	pick,
	pillow,
	cleo,
	appdirs,
	m3u8
}: buildPythonPackage rec {
	pname = "streamrip";
	version = "dev";
	format = "pyproject";
	disabled = pythonOlder "3.8";

	src = fetchFromGitHub {
		owner = "nathom";
		repo = pname;
		rev = version;
		sha256 = "sha256-Mdj3zO4YJM++PetEhk0g24UABE4Sii0JkPVJP9D4AtI=";
	};

	doCheck = false;
	pythonImportsCheck = [ "streamrip" ];
	propagatedBuildInputs = [
		requests
		poetry-core
		mutagen
		click
		tqdm
		tomlkit
		pathvalidate
		pick
		pillow
		deezer-py
		pycryptodomex
		cleo
		appdirs
		m3u8
		aiofiles
		aiohttp
		aiodns
	];

	meta = with lib; {
		description = "A scriptable music downloader for Qobuz, Tidal, SoundCloud, and Deezer";
		homepage = "https://github/nathom/streamrip/tree/dev";
		license = licenses.gpl3Plus;
		platforms = platforms.linux;
		maintainers = with maintainers; [ t3mpt0n ];
	};
}
