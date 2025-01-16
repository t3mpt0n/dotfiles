{
  self,
  pkgs,
  lib,
  ...
}: let
  inherit (self.outputs.packages.x86_64-linux) attractplus redream;
in {
  home.packages = with pkgs; [
    parsec-bin
    lutris
    steam-rom-manager
    protontricks
    protonup-qt
    heroic-unwrapped
    gamemode
    pegasus-frontend
    iortcw
    libsForQt5.kget
    mangohud
    dualsensectl
    atlauncher
    trigger-control
    mame
    mame-tools
    gamepad-tool
    lunar-client
    lutris
    osu-lazer-bin
  ];
}
