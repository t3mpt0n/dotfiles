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
    ./thunar.nix
    ./obs.nix
    ./browser.nix
    ./flatpak.nix
    ./games.nix
  ];

  home.packages = with pkgs; [
    discord-canary
    betterdiscordctl
    mono
    nicotine-plus
    betterdiscord-installer
    corectrl /* Control AMDGPU Profiles */
    home-manager
    dotnet-sdk
    tauon
    python312Packages.deemix
    stremio
    winetricks
    kid3
    retrofe
    aria
    pavucontrol
    keepassxc
    aria
    monero-gui
    xmrig
    cosmic-comp
    cosmic-icons
    cosmic-settings
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    gimp-with-plugins
    inkscape-with-extensions
    (nerdfonts.override { fonts = [ "FiraCode" "AnonymousPro" "3270" "Iosevka" "NerdFontsSymbolsOnly" ]; })
  ];
}
