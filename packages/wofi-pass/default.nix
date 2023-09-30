{
  stdenvNoCC,
  lib,
  fetchFromGitHub,
  makeWrapper,
  coreutils,
  findutils,
  pwgen,
  wofi,
  wl-clipboard,
  wl-clipboard-x11,
  wtype,
  pass-wayland,
  gnupg,
  pinentry,
  ...
}: stdenvNoCC.mkDerivation rec {
  pname = "wofi-pass";
  version = "v23.1.0";

  src = fetchFromGitHub {
    owner = "schmidtandreas";
    repo = "wofi-pass";
    rev = version;
    sha256 = "sha256-WX162R7cT0tYkhSBBBYxk5WF3MEYH9FIaQ/nhGP5TQc=";
  };


  nativeBuildInputs = [ makeWrapper ];
  dontBuild = true;

  outputs = [ "out" "man" ];

  installPhase = ''
      mkdir -p $man/share
      cp -r man $man/share
      mkdir -p $out/bin
      cp -a wofi-pass $out/bin
    '';

  wrapperPath = with lib; makeBinPath [
    coreutils
    findutils
    pwgen
    wofi
    wl-clipboard
    wl-clipboard-x11
    gnupg
    pinentry
    wtype
    (pass-wayland.withExtensions (ext: [ ext.pass-otp ]))
  ];

  fixupPhase = ''
    patchShebangs $out/bin

    wrapProgram $out/bin/wofi-pass \
      --prefix PATH : "${wrapperPath}"
    '';

  meta = {
    description = "A Wayland-native interface for conveniently using pass";
    homepage = "https://github.com/schmidtandreas/wofi-pass";
    license = lib.licenses.gpl2Plus;
    platforms = lib.platforms.linux;
    maintainers = with lib.maintainers; [ t3mpt0n ];
  };
}
