{
  lib,
  stdenv,
  pkg-config,
  libGLU,
  fluidsynth,
  libmad,
  SDL2_image,
  SDL2_mixer,
  SDL2_net,
  dumb,
  portmidi,
  libzip,
  cmake,
  ninja,
  imagemagick,
  gnumake,
  fetchFromGitHub
}: stdenv.mkDerivation rec {
  pname = "dsda-doom";
  version = "0.27.4";
  src = fetchFromGitHub {
    owner = "kraflab";
    repo = "dsda-doom";
    rev = "v${version}";
    sha256 = "sha256-eH4qYv/+IJOo/t9FM0WkWr4L/iSPI4PdWV+D0suiLIw=";
  };

  nativeBuildInputs = [ pkg-config cmake imagemagick gnumake ninja ];
  buildInputs = [ SDL2_image SDL2_mixer SDL2_net fluidsynth libGLU libmad dumb portmidi libzip ];

  enableParallelBuilding = true;

  cmakeFlags = [
    "-S ../prboom2"
    "-DCMAKE_BUILD_TYPE=Release"
    "-G Ninja"
  ];
}
