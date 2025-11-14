{
  lib,
  pkgs,
  config,
  ...
}: {
  home.packages = with pkgs; [
    winePackages.waylandFull
    winePackages.fonts
    winetricks
    protontricks
    protonup-qt
    bottles
  ];
}
