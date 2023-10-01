{
  lib,
  stdenv,
  fetchFromGitHub,
  pkg-config,
  automake,
  autoconf,
  autoconf-archive,
  SDL2,
  zlib,
  libarchive,
  soxr,
  gnome,
  xdg-utils,
  fltk,
  libGLU,
  libGL,
  gdk-pixbuf,
  unzip,
  makeWrapper,
  wrapGAppsHook,
}: stdenv.mkDerivation rec {
  pname = "nestopia";
  version = "1.52.0";
  src = fetchFromGitHub {
    owner = "0ldsk00l";
    repo = "nestopia";
    rev = "3746b104d875670df07e49295d40eba7ad4c8a44";
    sha256 = "sha256-bMiZOUKqNy3hBCcvmwf7smkoTbphChRTaO5dHEZCZC4=";
  };

  nativeBuildInputs = [ pkg-config autoconf autoconf-archive automake makeWrapper unzip wrapGAppsHook ];
  buildInputs = [ SDL2 zlib libarchive soxr fltk xdg-utils gnome.adwaita-icon-theme gdk-pixbuf libGL libGLU ];

  buildPhase = ''
    autoreconf -vif
    ./configure
    make -j$(nproc)
  '';

  installPhase = ''
    mkdir -p $out/bin
    cp -a nestopia $out/bin
  '';

  fixupPhase = ''
    for f in $out/bin/*; do
      wrapProgram $f \
        --prefix XDG_DATA_DIRS : "$GSETTINGS_SCHEMAS_PATH:$out/share"
    done
  '';
}
