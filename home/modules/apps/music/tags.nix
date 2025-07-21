{
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    kid3-qt
  ];
}
