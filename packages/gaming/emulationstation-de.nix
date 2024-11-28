{
  fetchFromGitLab,
  pkgs,
  mkPak
}: mkPak rec {
  pname = "emulationstation-de";
  version = "3.0.3";
  src = fetchFromGitLab {
    owner = "es-de";
    repo = "${pname}";
    rev = "v${version}";
    hash = "sha256-w/Kz9Hox5/Ed8n/e2qUF3tfm+a0YNTK1hC1hDp3Xa9w=";
  };

  nativeBuildInputs = with pkgs; [ cmake pkg-config ];
  buildInputs = with pkgs; [ SDL2 ffmpeg freeimage freetype libgit2 pugixml poppler alsa-lib llvmPackages.libcxxClang ];
}
