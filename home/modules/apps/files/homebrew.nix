{
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    hdl-dump
  ];
}
