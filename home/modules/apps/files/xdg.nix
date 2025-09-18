{ lib, pkgs, ... }:
{
  xdg.enable = true;
  xdg.userDirs.enable = true;
  home.packages = with pkgs; [
    xdg-utils
  ];
}
