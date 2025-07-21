{
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    wineWowPackages.stableFull
    mono
    winetricks
  ];
}
