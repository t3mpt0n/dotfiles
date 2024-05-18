{
  mkPak,
  pkgs,
  fetchFromGitHub,
  ...
}: mkPak rec {
  pname = "wut-tools";
  version = "1.3.4";
  src = fetchFromGitHub {
    owner = "devkitPro";
    repo = "wut-tools";
    rev = "v${version}";
    hash = "sha256-KSnIGyflaTJhklEO76J4pODAlxRvjGJwhLBoKfCYm98=";
    fetchSubmodules = true;
  };
  preBuild = " export LD=$CC ";
  nativeBuildInputs = with pkgs; [ autoreconfHook pngpp pkg-config ];
  buildInputs = with pkgs; [ libtool libz.dev freeimage ];
}
