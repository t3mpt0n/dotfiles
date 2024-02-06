{
  self,
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    parsec-bin
    lutris
    steam-rom-manager
    protontricks
    protonup-qt
    self.outputs.packages.x86_64-linux.attractplus
    heroic-unwrapped
    gamemode
    libsForQt5.kget
    mangohud
  ];
}
