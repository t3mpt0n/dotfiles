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
    ./nvim
    ./direnv.nix
  ];

  home.packages = with pkgs; [
    self.inputs.t3mpt0n_nvim.outputs.packages.x86_64-linux.default
    vesktop
    self.inputs.homebrew.outputs.packages.x86_64-linux.libray
    dex
    xd
    betterdiscordctl
    telegram-desktop
    mono
    discord
    discord-rpc
    nicotine-plus
    boilr
    attract-mode
    (pkgs.betterdiscord-installer.overrideAttrs {
      version = "1.10.1";
    })
    corectrl
    /*
    Control AMDGPU Profiles
    */
    home-manager
    dotnet-sdk
    filezilla
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
    nerd-fonts.fira-code
    nerd-fonts.iosevka
    nerd-fonts.iosevka-term
    nerd-fonts.symbols-only
    nerd-fonts._3270
    anonymousPro
    inter
  ];
}
