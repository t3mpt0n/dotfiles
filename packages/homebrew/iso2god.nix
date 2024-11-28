{
  rustBuild,
  pkgs,
  fetchFromGitHub,
  ...
}: rustBuild rec {
  pname = "iso2god-rs";
  version = "1.7.0";
  src = pkgs.fetchFromGitHub {
    owner = "iliazeus";
    repo = "iso2god-rs";
    rev = "v${version}";
    hash = "sha256-k09kADrcMQhHtSaR5L81UbvNzZXrj82XvhXai00EB0g=";
  };
  cargoHash = "sha256-zMskBSukcTC0244yud8Giqy3kRJxmjnmM8VSCKJNeMc=";

  preBuild = " export RUSTC_BOOTSTRAP=1 ";
  nativeBuildInputs = with pkgs; [ pkg-config ];
  buildInputs = with pkgs; [ openssl.dev ];
}
