{
  description = "Homebrew & Modding Stuff";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    devkitNix = {
      url = "github:knarkzel/devkitnix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, devkitNix, ... }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = import nixpkgs {
        inherit system;
      };
      inherit (pkgs) stdenv fetchFromGitHub fetchFromGitLab python3Packages;
      dkPPC = devkitNix.packages.x86_64-linux.devkitPPC;
      mkPak = stdenv.mkDerivation;
      rustBuild = pkgs.rustPlatform.buildRustPackage;
      pythonBuild = pkgs.python311Packages.buildPythonPackage;
      stdinh = { inherit mkPak pkgs fetchFromGitHub rustBuild; };
    in {
      devShells.default = pkgs.mkShell {
        buildInputs = with pkgs; [ dkPPC python311Packages.tkinter python311Packages.tqdm python311Packages.pillow python311Packages.pyinstaller-versionfile ];
        shellHook = " export DEVKITPRO=${dkPPC} ";
      };

      packages = {
        wut-tools = import ./wut-tools.nix stdinh;
        iso2god-rs = import ./iso2god.nix stdinh;
        libray = import ./libray.nix stdinh;

        wfs-fuse = pkgs.stdenv.mkDerivation rec {
          name = "wfs-fuse";
          version = "1.2.2";
          src = pkgs.fetchzip {
            url = "https://github.com/koolkdev/wfs-tools/releases/download/v${version}/wfs-tools-v${version}-linux-x86-64.zip";
            stripRoot = false;
            hash = "sha256-OQ/BIdMrad4TVCe3gTolfoqsm5FlhCnalfbnUnjZQHQ=";
          };
          wrapperPath = with pkgs; lib.makeBinPath [
            coreutils
            fuse
            zip
            boost
            cryptopp
          ];
          nativeBuildInputs = with pkgs; [ makeWrapper ];
          installPhase = ''
            mkdir -p $out/bin
            cp -a $src/* $out/bin/
          '';
          fixupPhase = ''
            wrapProgram $out/bin/wfs-fuse \
              --prefix PATH : "${wrapperPath}"

            wrapProgram $out/bin/wfs-extract \
              --prefix PATH : "${wrapperPath}"

            wrapProgram $out/bin/wfs-file-injector \
              --prefix PATH : "${wrapperPath}"

            wrapProgram $out/bin/wfs-info \
              --prefix PATH : "${wrapperPath}"

            wrapProgram $out/bin/wfs-reencryptor \
              --prefix PATH : "${wrapperPath}"
          '';
        };
      };
    });
}
