{
  libcurl ? true,
  libarchive ? true,
  xinerama ? false,
  fontconfig ? true,
  libdwarf ? true,
  fetchFromGitHub,
  mkPak,
  pkgs
}: mkPak rec {
  pname = "attract";
  version = "2.7.0";
  src = fetchFromGitHub {
    owner = "mickelson";
    repo = "attract";
    rev = "v${version}";
    hash = "sha256-/ak3CBQOJvxFAYJZTypelLzQSPdXSTFIYuOSTCQzWTE=";
  };

  nativeBuildInputs = with pkgs; [ pkg-config ];
  patchPhase = ''
            sed -i "s|prefix\ ?=\ /usr/local|prefix\ ?=\ $out|" Makefile
          '';
  buildInputs = with pkgs; [ expat ffmpeg_4 freetype libjpeg
                  libGLU libGL openal sfml zlib ]
  ++ lib.optionals fontconfig [ pkgs.fontconfig ]
  ++ lib.optionals libarchive [ pkgs.libarchive ]
  ++ lib.optionals libcurl [ pkgs.libgnurl ]
  ++ lib.optionals xinerama [ pkgs.xorg.libXinerama ]
  ++ lib.optionals libdwarf [ pkgs.libdwarf ];
}
