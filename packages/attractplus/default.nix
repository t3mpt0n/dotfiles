{
  lib,
  fetchurl,
  stdenv,
  pkg-config,
  sfml,
  libarchive,
  ffmpeg_4,
  freetype,
  openal,
  libXinerama,
  curlWithGnuTls,
  libGL,
  libGLU,
  libjpeg,
  expat,
  p7zip,
  bash,
  glibc,
  autoPatchelfHook,
  libgnurl,
  devdocs-desktop,
  makeWrapper
}: stdenv.mkDerivation rec {
  pname = "attractplus";
  version = "3.0.6";

  src = fetchurl {
    url = "https://github.com/oomek/attractplus/releases/download/${version}/attractplus-${version}-Linux.x64.X11-static.7z";
    sha256 = "sha256-9o0X62NppW6lciW27hRYC/lIWip2/4TM2ajU2hRCEQM=";
  };
  dontBuild = true;
  unpackPhase = ''
    cp $src ${pname}.7z
    7z x ${pname}.7z
    rm attractplus.7z
  '';
  installPhase = ''
    chmod u+x attractplus
    mkdir -p $out/bin
    mv attractplus $out/bin
  '';

  nativeBuildInputs = [
    p7zip
    autoPatchelfHook 
    sfml
    libarchive
    freetype
    openal
    libXinerama
    libGL
    curlWithGnuTls
    bash
    glibc
    libGLU
    libjpeg
    expat
    ffmpeg_4
    libgnurl
  ];
}
