{
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    filezilla
  ];
}
