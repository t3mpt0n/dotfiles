{
  lib,
  stdenv,
  fetchurl,
  autoPatchelfHook,
  ell,
  gcc,
  SDL,
  waylandpp
}: stdenv.mkDerivation rec {
  pname = "redream";
  version = "1.5.0-1107-g9b82c12";
  src = fetchurl {
    url = "https://redream.io/download/redream.x86_64-linux-v${version}.tar.gz";
    hash = "sha256-jZuCkjFzpBuyxCJErsr14/LUcN0fz7pEbaVwbqO9jhE=";
  };
  nativeBuildInputs = [
    autoPatchelfHook
  ];
  buildInputs = [
    ell
    gcc.cc.libgcc
    stdenv.cc.cc.lib
    SDL
    waylandpp
  ];
  unpackPhase = ''
    cp $src redream.tar.gz
    tar -xzvf redream.tar.gz
  '';
  installPhase = ''
    chmod u+x redream
    mkdir -p $out/bin
    install -m755 -D redream $out/bin/redream
  '';
}
