pargs@{
  pkgs,
  ...
}: pkgs.stdenv.mkDerivation {
  pname = "XenonRecompiler";
  version = "c017eb6";
  src = pkgs.fetchFromGitHub {
    owner = "hedge-dev";
    repo = "XenonRecomp";
    rev = "c017eb630ab917bffd3bc6a0a46995b49e7d8049";
    hash = "sha256-+ijvZ+Y+nmn0Y9OUKAxDUWZVVKGJvYmsHl+F52eAUsk=";
    fetchSubmodules = true;
  };

  nativeBuildInputs = with pkgs; [ pkg-config cmake clang];
  installPhase = ''
    mkdir -p $out/bin
    cp -a $src/* $out/bin/
  '';
}
