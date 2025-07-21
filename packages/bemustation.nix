pargs@{pkgs, lib, ...}:
let
  
in pkgs.stdenv.mkDerivation rec {
  pname = "retropie-emulationstation";
  version = "unstable-2025-04-13";

  src = pkgs.fetchFromGitHub {
    owner = "batocera-linux";
    repo = "batocera-emulationstation";
    rev = "042a615e00cbf0109d380a87008dfb49461f5d1f";
    sha256 = "sha256-zVnlPc/qA+Af5b8AO6AMNHkpg3+5h+2m0nLLSr1oODQ=";
    fetchSubmodules = true;
  };

  nativeBuildInputs = with pkgs; [
    cmake
    pkg-config
    gettext
  ];

  buildInputs = with pkgs; [
    SDL2
    SDL2_mixer
    freeimage
    freetype
    curl
    rapidjson
    libvlc
    boost
    alsa-lib
    mesa
    mesa-gl-headers
    libcec
    binutils
    libGL
    libGLU
  ];

  preBuild = ''
    export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:${lib.makeLibraryPath buildInputs}
  '';
  
  cmakeFlags = [
    "-DSDLMIXER_INCLUDE_DIR=${pkgs.SDL2_mixer.dev}/include/SDL2"
  ];

  postInstall = ''
    mkdir -p $out/etc/emulationstation
    cp -r $src/resources $out/etc/emulationstation/
  '';
  meta = with lib; {
    description = "RetroPie fork of EmulationStation";
    homepage = "https://github.com/RetroPie/EmulationStation";
    license = licenses.mit;
    maintainers = with maintainers; [ t3mpt0n ];
    platforms = platforms.linux;
  };
}
