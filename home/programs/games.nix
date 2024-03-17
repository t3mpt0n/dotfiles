{
  self,
  pkgs,
  lib,
  ...
}: let
  inherit (self.outputs.packages.x86_64-linux) attractplus attract redream;
in {
  home.packages = with pkgs; [
    parsec-bin
    lutris
    attract
    steam-rom-manager
    protontricks
    protonup-qt
    heroic
    gamemode
    pegasus-frontend
    libsForQt5.kget
    mangohud
    dualsensectl
    trigger-control
    mame
    mame-tools
    gamepad-tool
  ];
}
