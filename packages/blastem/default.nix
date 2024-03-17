{
  lib,
  stdenv,
  fetchurl,
  autoPatchelfHook,
  libGL,
  glibc,
  glew-egl,
  libGLU,
  libX11,
  makeWrapper,
  pkg-config,
  imagemagick,
  python312,
  python312Packages,
  SDL2
}: let
  ver = "0.6.3";
  revision = "cf3e8a19aa25";
  dir = "blastem64-${ver}-pre-${revision}";
in stdenv.mkDerivation rec {
    pname = "blastem";
    version = "${revision}"; # compiled Feb. 27th 2024 (07:47)
    src = fetchurl {
      url = "https://www.retrodev.com/blastem/nightlies/blastem64-${ver}-pre-${version}.tar.gz";
      hash = "sha256-W+QdyLu+GdecYbkU+nU7duJIh0oBMAFk3gWeyQwzmiA=";
    };
    nativeBuildInputs = [
      autoPatchelfHook
      pkg-config
      imagemagick
      #makeWrapper
    ];
    buildInputs = [
      glew-egl
      SDL2
    ];
    unpackPhase = ''
    cp $src blastem.tar.gz
    tar -xzvf blastem.tar.gz
  '';
    installPhase = ''
    mkdir -p $out/bin
    install -m755 -D ${dir}/blastem $out/bin/blastem
    install -m755 -D ${dir}/zdis $out/bin/zdis
    install -m755 -D ${dir}/dis $out/bin/dis
    install -m755 -D ${dir}/termhelper $out/bin/termhelper
    install -m755 -D ${dir}/*.cfg $out/bin/
  '';
##    wrapperPath = with lib; makeBinPath [
##      SDL2
##      libGL
##      libGLU
##      glew
##    ];
##    fixupPhase = ''
##      wrapProgram $out/bin/blastem \
##        --prefix PATH : "${wrapperPath}"
##    '';
  }
