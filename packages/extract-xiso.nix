{
  stdenv,
  lib,
  pkg-config,
  cmake,
  fetchFromGitHub
}: let
in stdenv.mkDerivation rec {
  pname = "extract-xiso";
  version = "build-202505152050";
  src = fetchFromGitHub {
    owner = "XboxDev";
    repo = pname;
    rev = version;
    sha256 = "sha256-KZxnS63MhpmzwxCPFi+op5l/vM6P9GYc+SXmNFmEyc8=";
  };

  nativeBuildInputs = [
    cmake
    pkg-config
  ];

  meta = with lib; {
    description = "Xbox ISO Creation/Extraction utility.";
    homepage = "https://github.com/XboxDev/extract-xiso";
    maintainers = with maintainers; [ t3mpt0n ];
  };
}
