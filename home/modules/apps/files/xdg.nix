{ lib, pkgs, ... }:
{
  xdg.enable = true;
  xdg.userDirs.enable = true;
  xdg.configFile."mimeapps.list".force = true;
  home.packages = with pkgs; [
    xdg-utils
  ];
}
