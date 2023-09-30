{
  stdenv,
  fetchFromGitLab,
  lib,
  cmake,
  pkg-config,
  gnumake,
  SDL2,
  ffmpeg,
  freeimage,
  freetype,
  libgit2,
  pugixml,
  poppler,
  alsa-lib
}: stdenv.mkDerivation rec {
  pname = "emulationstation-de";
  version = "2.1.1";

  src = fetchFromGitLab {
    owner = "es-de";
    repo = "emulationstation-de";
    rev = "28f880d995f527701bba4cf1519713fce01f678e";
    sha256 = "sha256-nWuwRPdCugzUxP2mYm4HpJgp1C99FehxUN/URS9IYV0=";
  };

  nativeBuildInputs = [ gnumake cmake pkg-config ];
  buildInputs = [ SDL2 ffmpeg freeimage freetype libgit2 pugixml poppler alsa-lib ];

  fixupPhase = ''
    mv $out/bin/emulationstation $out/bin/emulationstation-de
  '';

  meta = {
    description = "EmulationStation Desktop Edition is a frontend for browsing and launching games from your multi-platform game collection.";
    homepage = "https://gitlab.com/es-de/emulationstation-de";
    license = lib.licenses.mit;
    platforms = lib.platforms.linux;
    maintainers = with lib.maintainers; [t3mpt0n];
  };
}
