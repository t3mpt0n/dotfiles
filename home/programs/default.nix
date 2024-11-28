{
  pkgs,
  self,
  lib,
  ...
}: {
  imports = [
    ./git.nix
    ./mpd.nix
    ./mpv.nix
    ./pass.nix
    ./mako.nix
    # ./thunar.nix
    ./obs.nix
    ./browser.nix
    ./flatpak.nix
    ./games.nix
  ];

  home.packages = with pkgs; [
    vesktop
    zoom-us
    self.inputs.homebrew.outputs.packages.x86_64-linux.libray
    dex
    xd
    betterdiscordctl
    telegram-desktop
    mono
    nicotine-plus
    attract-mode
    (pkgs.betterdiscord-installer.overrideAttrs {
      version = "1.10.1";
    })
    corectrl /* Control AMDGPU Profiles */
    home-manager
    dotnet-sdk
    tauon
    python312Packages.deemix
    stremio
    winetricks
    kid3
    retrofe
    libsForQt5.dolphin
    libsForQt5.dolphin-plugins
    aria
    pavucontrol
    keepassxc
    aria
    cosmic-comp
    cosmic-icons
    cosmic-settings
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
    gimp
    inkscape-with-extensions
    (nerdfonts.override { fonts = [ "FiraCode" "AnonymousPro" "3270" "Iosevka" "NerdFontsSymbolsOnly" ]; })
    inter
  ];
}
