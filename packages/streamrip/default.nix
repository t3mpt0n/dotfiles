{
  lib,
  pkg-config,
  fetchFromGitHub,
  fetchurl,
  stdenv,
  buildPythonPackage,
  requests,
  poetry-core,
  mutagen,
  click,
  aiolimiter,
  tqdm,
  tomlkit,
  pathvalidate,
  pick,
  pillow,
  deezer-py,
  pycryptodomex,
  cleo,
  # simple-term-menu,
  appdirs,
  m3u8,
  aiofiles,
  aiohttp,
  aiodns,
  rich,
  ...
}: buildPythonPackage rec {
  pname = "streamrip";
  version = "2.0.5";
  format = "pyproject";
  src = fetchFromGitHub {
    owner = "nathom";
    repo = pname;
    rev = "v${version}";
    hash = "sha256-KwMt89lOPGt6nX7ywliG/iAJ1WnG0CRPwhAVlPR85q0=";
  };

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
    # simple-term-menu
    appdirs
    m3u8
    aiofiles
    aiohttp
    aiodns
    rich
    pkg-config
  ];
}
