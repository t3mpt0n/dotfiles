{
  fetchFromGitLab,
  pkgs,
  mkPak
}: mkPak rec {
  pname = "emulationstation-de";
  version = "3.0.2";
  src = fetchFromGitLab {
    owner = "es-de";
    repo = "${pname}";
    rev = "v${version}";
    hash = "sha256-RGlXFybbXYx66Hpjp2N3ovK4T5VyS4w0DWRGNvbwugs=";
  };

  nativeBuildInputs = with pkgs; [ cmake pkg-config ];
  buildInputs = with pkgs; [ SDL2 ffmpeg freeimage freetype libgit2 pugixml poppler alsa-lib llvmPackages.libcxxClang ];
}
