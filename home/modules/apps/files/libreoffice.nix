{
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs; [ libreoffice-qt6-fresh jre];
}
