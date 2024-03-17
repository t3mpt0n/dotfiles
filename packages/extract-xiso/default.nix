{
  lib,
  stdenv,
  fetchFromGitHub,
  cmake,
  pkg-config,
  ...
}: stdenv.mkDerivation rec {
  pname = "extract-xiso";
  version = "build-202303040307";
  src = fetchFromGitHub {
    owner = "XboxDev";
    repo = "extract-xiso";
    rev = "${version}";
    hash = "sha256-nPkdyxI2gxxCpE4sG9sax+mbKkhbe3zZENvlO7JSUEQ=";
  };

  nativeBuildInputs = [ pkg-config cmake ];

  meta = with lib; {
    description = "Xbox ISO Creation/Extraction utility.";
    homepage = "https://github.com/${owner}/${repo}";
    maintainers = with maintainers; [ t3mpt0n ];
  };
}
