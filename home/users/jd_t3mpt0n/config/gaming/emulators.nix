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
    retrofe
    rmg-wayland
    pcsx2
    ppsspp-sdl-wayland
    pegasus-frontend
  ];

  jc'.home.gaming = {
    retroarch = {
      enable = true;
      corelist = with pkgs.libretro; [
        mame
        fbneo
        mesen
        mesen-s
        beetle-pce
        beetle-saturn
        swanstation
      ];
    };
  };
}
