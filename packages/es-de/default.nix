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
  version = "2.2.0-beta";

  src = fetchFromGitLab {
    owner = "es-de";
    repo = "emulationstation-de";
    rev = "00a226062fff37209d98e0ab048ac89af50ecacc";
    sha256 = "sha256-DOyFLHaK2Q4+3RymzX8Tz5Z1n2H/N0C85qSZ1w8iww8=";
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
