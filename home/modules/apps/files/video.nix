{
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    vlc
  ];
}
