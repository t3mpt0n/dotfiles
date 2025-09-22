{
  stdenv,
  fetchFromGitHub,
  cmake,
  ninja,
  pkg-config,
  ccache,
  libX11,
  libGL,
  libGLU,
  gtk3,
  librashader,
  libpulseaudio,
  openal,
  sdl3
}:
stdenv.mkDerivation rec {
  name = "ares";
  version = "146";
  src = fetchFromGitHub {
    owner = "ares-emulator";
    repo = "ares";
    rev = "v${version}";
    hash = "sha256-DCHMr4nwTpZIY4t+c8XYfTQ3wzznmr83r4OdG2F0fWI=";
  };

  nativeBuildInputs = [
    cmake
    ninja
    pkg-config
  ];

  buildInputs = [
    libX11
    libGL
    libGLU
    gtk3
    librashader
    openal
    libpulseaudio
    sdl3
  ];

  cmakeFlags = [
    "-DARES_SKIP_DEPS=ON"
  ];
}
