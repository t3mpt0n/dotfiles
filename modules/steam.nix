{
  config,
  lib,
  pkgs,
  ...
}: {
  programs = {
    steam = {
      enable = true;
      package = pkgs.steam.override {};
      extraPackages = with pkgs; [
        SDL2
        sdl3
        SDL
        mono
        wine
      ];
    };

    gamescope = {
      enable = true;
      capSysNice = true;
    };
  };

  environment.systemPackages = let
    steam-run =
      (pkgs.steam.override {
        extraLibraries = pkgs:
          with pkgs; [
            fuse
          ];
      }).run;
  in [
    steam-run
    pkgs.steam-rom-manager
    pkgs.steamtinkerlaunch
    pkgs.gamemode
    pkgs.mangohud
  ];
}
