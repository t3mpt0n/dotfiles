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
    webcord
    betterdiscordctl
    betterdiscord-installer
    corectrl /* Control AMDGPU Profiles */
    home-manager
    dotnet-sdk
#    self.outputs.packages.x86_64-linux.streamrip ## [py312 BROKEN]
    winetricks
    kid3
    pavucontrol
    keepassxc
    monero-gui
    xmrig
    cosmic-comp
    cosmic-icons
    cosmic-settings
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    gimp-with-plugins
    (nerdfonts.override { fonts = [ "FiraCode" "AnonymousPro" "3270" "Iosevka" "NerdFontsSymbolsOnly" ]; })
  ];
}
