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
    ppsspp-sdl-wayland
    pcsx2
    gopher64
    xenia-canary
    duckstation
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
