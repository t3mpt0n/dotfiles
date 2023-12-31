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
  simple-term-menu,
  pillow,
  cleo,
  appdirs,
  m3u8,
  rich,
  aiolimiter
}: buildPythonPackage rec {
  pname = "streamrip";
  version = "dev";
  format = "pyproject";
  disabled = pythonOlder "3.8";

  src = fetchFromGitHub {
    owner = "nathom";
    repo = pname;
    rev = version;
    sha256 = "sha256-qVUEjWXKxGe07v421eHvxQzc4CGubKAGvw5zJ4e9GHQ=";
  };

  doCheck = false;
  pythonImportsCheck = [ "streamrip" ];
  propagatedBuildInputs = [
    requests
    poetry-core
    mutagen
    click
    aiolimiter
    tqdm
    tomlkit
    pathvalidate
    pick
    pillow
    deezer-py
    pycryptodomex
    cleo
    simple-term-menu
    appdirs
    m3u8
    aiofiles
    aiohttp
    aiodns
    rich
  ];

  meta = with lib; {
    description = "A scriptable music downloader for Qobuz, Tidal, SoundCloud, and Deezer";
    homepage = "https://github.com/nathom/streamrip/tree/dev";
    license = licenses.gpl3Plus;
    platforms = platforms.linux;
    maintainers = with maintainers; [ t3mpt0n ];
  };
}
