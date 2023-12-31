{
  self,
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    parsec-bin
    lutris
    steam
    steam-run
    steam-rom-manager
    protontricks
    protonup-qt
    self.outputs.packages.x86_64-linux.attractplus
    prismlauncher-qt5
    heroic-unwrapped
    gamemode
    gamescope
  ];
}
