{
  pkgs,
  self,
  ...
}: {
  imports = [
    ./git.nix
    ./mpd.nix
    ./mpv.nix
    ./pass.nix
    ./dunst.nix
    ./thunar.nix
    ./obs.nix
    ./minecraft.nix
  ];

  programs = {
    firefox = {
      enable = true;
    };
  };

  home.packages = with pkgs; [
    discord-canary
    webcord
    betterdiscordctl
    betterdiscord-installer
    corectrl /* Control AMDGPU Profiles */
    home-manager
    android-tools
    droidcam
    dotnet-sdk
    self.outputs.packages.x86_64-linux.streamrip
    winetricks
    kid3
    pavucontrol
    keepassxc
    protontricks
    protonup-qt
    monero-gui
    xmrig
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    gimp-with-plugins
    (nerdfonts.override { fonts = [ "FiraCode" "AnonymousPro" "3270" "Iosevka" "NerdFontsSymbolsOnly" ]; })
  ];
}
