{
  rustBuild,
  pkgs,
  fetchFromGitHub,
  ...
}: rustBuild rec {
  pname = "iso2god-rs";
  version = "1.4.8";
  src = pkgs.fetchFromGitHub {
    owner = "iliazeus";
    repo = "iso2god-rs";
    rev = "v${version}";
    hash = "sha256-zf6wWwZlHLvB2lvq8jj+iJVTb0j/7HaD4JIAPXOM7WQ=";
  };
  cargoHash = "sha256-ZHDV2DZZomjhb77D7tHdYFkva3xp+RRGgOy9Gmi81xI=";

  preBuild = " export RUSTC_BOOTSTRAP=1 ";
  nativeBuildInputs = with pkgs; [ pkg-config ];
  buildInputs = with pkgs; [ openssl.dev ];
}
