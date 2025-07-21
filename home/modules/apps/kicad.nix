{
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    kicad
  ];
}
