{
  lib,
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    mesen
    mame
    mame-tools
    flycast
    retrofe
    rmg-wayland
    pcsx2
  ];
}
