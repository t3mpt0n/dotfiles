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
  version = "2.2.1";

  src = fetchFromGitLab {
    owner = "es-de";
    repo = "emulationstation-de";
    rev = "5120f8b440909d06060a9c68e879a160ffa71b28";
    sha256 = "sha256-BQ+//R89rzqj/0NP6dPxLbAxGPgGxaxKlj/ijTzz5CQ=";
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
