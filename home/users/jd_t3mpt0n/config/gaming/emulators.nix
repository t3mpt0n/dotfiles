{
  lib,
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; let
    libretroCores = with pkgs.libretro; [
      mesen
      mesen-s
      mupen64plus
      swanstation
    ];
  in [
    mesen
    mame
    mame-tools
    flycast
    retrofe
    rmg-wayland
    pcsx2
    ppsspp-sdl-wayland

    retroarch-bare
  ]
  ++ libretroCores;
}
