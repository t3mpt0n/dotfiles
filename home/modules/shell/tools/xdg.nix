{
  lib,
  pkgs,
  config,
  ...
}: {
  xdg = {
    enable = true;
    userDirs.enable = true;
  };

  home.packages = with pkgs; [
    xdg-utils
  ];
}
