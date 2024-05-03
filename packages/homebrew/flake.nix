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
      dkPPC = devkitNix.packages.x86_64-linux.devkitPPC;
    in {
      devShells.default = pkgs.mkShell {
        buildInputs = with pkgs; [ dkPPC python311Packages.tkinter python311Packages.tqdm python311Packages.pillow python311Packages.pyinstaller-versionfile ];
        shellHook = " export DEVKITPRO=${dkPPC} ";

      };

      packages = {
        wut-tools = pkgs.stdenv.mkDerivation rec {
          name = "wut-tools";
          version = "1.3.4";
          src = pkgs.fetchFromGitHub {
            owner = "devkitPro";
            repo = "wut-tools";
            rev = "v${version}";
            hash = "sha256-KSnIGyflaTJhklEO76J4pODAlxRvjGJwhLBoKfCYm98=";
            fetchSubmodules = true;
          };
          preBuild = " export LD=$CC ";
          nativeBuildInputs = with pkgs; [ autoreconfHook pngpp pkg-config ];
          buildInputs = with pkgs; [ libtool libz.dev freeimage ];
        };

        iso2god-rs = pkgs.rustPlatform.buildRustPackage rec {
          name = "iso2god-rs";
          version = "1.4.8";
          src = pkgs.fetchFromGitHub {
            owner = "iliazeus";
            repo = "iso2god-rs";
            rev = "v${version}";
            hash = "sha256-zf6wWwZlHLvB2lvq8jj+iJVTb0j/7HaD4JIAPXOM7WQ=";
          };
          cargoHash = "sha256-WC1be8nea/kvzkMEK+3Rk4B1OdhLgqjENChRidSyWgI=";

          preBuild = " export RUSTC_BOOTSTRAP=1 ";
          nativeBuildInputs = with pkgs; [ pkg-config ];
          buildInputs = with pkgs; [ openssl.dev ];
        };

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
        libray = pkgs.python311Packages.buildPythonPackage rec {
          pname = "libray";
          version = "0.0.10";
          src = pkgs.fetchPypi {
            inherit pname version;
            hash = "sha256-a1wO8GOF8PIqmzFr5+s9Nh6sZHHpVxtGaFrbjwErUX8=";
          };

          doCheck = false;
          propagatedBuildInputs = with pkgs.python311Packages; [ pycryptodome html5lib tqdm beautifulsoup4 requests setuptools pip wheel urllib3 ];
        };
      };
    });
}
