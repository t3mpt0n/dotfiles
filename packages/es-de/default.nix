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
  version = "3.0.0";

  src = fetchFromGitLab {
    owner = "es-de";
    repo = "emulationstation-de";
    rev = "v${version}";
    sha256 = "sha256-BAfsRXh1o5AUPCEaMcrJwOQOOdSENdmGpl3wjbsCDzM=";
  };

  nativeBuildInputs = [ gnumake cmake pkg-config ];
  buildInputs = [ SDL2 ffmpeg freeimage freetype libgit2 pugixml poppler alsa-lib ];

##  fixupPhase = ''
##    mv $out/bin/emulationstation $out/bin/emulationstation-de
##  '';
##
  meta = {
    description = "EmulationStation Desktop Edition is a frontend for browsing and launching games from your multi-platform game collection.";
    homepage = "https://gitlab.com/es-de/emulationstation-de";
    license = lib.licenses.mit;
    platforms = lib.platforms.linux;
    maintainers = with lib.maintainers; [t3mpt0n];
  };
}
