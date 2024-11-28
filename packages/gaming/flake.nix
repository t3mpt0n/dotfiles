{
  description = "My Gaming Packages.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = inputs@{ self, nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = import nixpkgs {
        inherit system;
      };
      inherit (pkgs) stdenv mkShell fetchFromGitHub fetchFromGitLab fetchurl lib fetchzip;
      mkPak = stdenv.mkDerivation;
    in {
      devShells = {
        default = mkShell {
          buildInputs = with pkgs; [ SDL2 libGL libGLU cmake ninja ];
        };

        blastem = mkShell {
          buildInputs = with pkgs; [ glew SDL2 libz zlib gnumake cmake mercurialFull ];
          shell = pkgs.fish;
        };
      };

      packages = rec {
        attract = import ./attract.nix {
          inherit fetchFromGitHub pkgs mkPak;
        };

#        attractplus = let
#          opt = {
#            libcurl = true;
#            libarchive = true;
#            xinerama = false;
#          };
#          in mkPak rec {
#          pname = "attractplus";
#          version = "3.0.8";
#          src = fetchFromGitHub {
#            owner = "oomek";
#            repo = "attractplus";
#            rev = "${version}";
#            hash = "sha256-wUCkX8HKl2lxREdyZq8lz1es6DhHMt4RJO1K7yoCP18=";
#          };
#
#          nativeBuildInputs = with pkgs; [ pkg-config libudev-zero ];
#          patchPhase = ''
#            sed -i "s|prefix\ ?=\ /usr/local|prefix\ ?=\ $out|" Makefile
#          '';
#          buildInputs = with pkgs; [ expat ffmpeg_4 freetype libjpeg
#                                     libGLU libGL openal zlib xorg.libX11 libvorbis.dev flac.dev xorg.libXrandr sfml ]
#          ++ lib.optionals opt.libcurl [ pkgs.libgnurl ]
#          ++ lib.optionals opt.libarchive [ pkgs.libarchive ]
#          ++ lib.optionals opt.xinerama [ pkgs.xorg.libXinerama ];
#          makeFlags = [ "-j8" "USE_SYSTEM_SFML=1" ];
#        };

        es-de = import ./emulationstation-de.nix {
          inherit pkgs mkPak fetchFromGitLab;
        };

        es-retropie = let
          in mkPak rec {
            pname = "es-retropie";
            version = "2.11.2";
            src = fetchFromGitHub {
              owner = "RetroPie";
              repo = "EmulationStation";
              rev = "v${version}";
              hash = "sha256-J5h/578FVe4DXJx/AvpRnCIUpqBeFtmvFhUDYH5SErQ=";
              fetchSubmodules = true;
            };

            nativeBuildInputs = with pkgs; [ cmake pkg-config ];
            buildInputs = with pkgs; [ SDL2 ffmpeg freeimage freetype libgit2 pugixml poppler alsa-lib llvmPackages.libcxxClang libGL libGLU libvlc vlc rapidjson ];
          };

        mesen = let
          extractzip = fetchzip {
            url = "https://nightly.link/SourMesen/Mesen2/workflows/build/master/Mesen%20(Linux%20x64%20-%20AppImage).zip";
            hash = "sha256-kv7AANsEQun9Z70fpjYVXzK6RpPZv1DnK76cPrald/U=";
          };
          appimage-file = "${extractzip}/Mesen.AppImage";
          in pkgs.appimageTools.wrapType2 {
          name = "mesen";
          src = appimage-file;
          extraPkgs = p: with p; [ SDL2 dotnet-runtime_8 icu libevdev ];
        };
      };
    });
}
