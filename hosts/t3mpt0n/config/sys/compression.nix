{
  lib,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    unrar
    unzip
    zip
    rar
    p7zip
    gnutar
  ];
}
