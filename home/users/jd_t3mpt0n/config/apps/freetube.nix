{
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    freetube
  ];
}
