{
  lib,
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; let
  in [
    mesen
    mame
    mame-tools
    flycast
    rmg-wayland
    ppsspp-sdl-wayland
  ];

  jc'.home.gaming = {
    retroarch = {
      enable = true;
      corelist = with pkgs.libretro; [
        mame
        blastem
        fbneo
        mesen
        mesen-s
        beetle-pce
        beetle-saturn
        swanstation
        pcsx2
      ];
    };
  };
}
