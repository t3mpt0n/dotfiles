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
      inherit (pkgs) stdenv fetchFromGitHub fetchFromGitLab;
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

##        wfs-fuse = pkgs.stdenv.mkDerivation rec {
##          name = "wfs-fuse";
##          version = "1.2.1";
##          src = pkgs.fetchFromGitHub {
##            owner = "koolkdev";
##            repo = "wfs-tools";
##            rev = "v${version}";
##            hash = "sha256-NRgndpVeswBzKy8diHdxrizb/nDR5v+gElkMlUIduMQ=";
##            fetchSubmodules = true;
##          };
##
##          nativeBuildInputs = with pkgs; [ cmake ninja jq cryptopp.dev ];
##          buildInputs = with pkgs; [ fuse zip boost ];
##          dontUseCMakeConfigure = true;
##        };
      };
    });
}
