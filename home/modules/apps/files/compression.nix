{
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    p7zip
    unrar
    unzip
  ];
}
