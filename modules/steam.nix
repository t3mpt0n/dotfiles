{
  config,
  lib,
  pkgs,
  ...
}: {
  programs = {
    steam = {
      enable = true;
      gamescopeSession = {
        enable = true;
      };
    };

    gamescope = {
      enable = true;
      args = [
        "--expose-wayland"
        "--hdr-enabled"
        "--hdr-itm-enable"
        "--adaptive-sync"
        "-w 2560"
        "-W 2560"
        "-h 1440"
        "-H 1440"
        "-e"
        "--steam"
        "-r 165"
      ];
      env = {
        WLR_RENDERER = "vulkan";
        DXVK_HDR = "1";
        ENABLE_GAMESCOPE_WSI = "1";
        WINE_FULLSCREEN_FSR = "1";
        SDL_VIDEODRIVER = "x11";
      };
    };
  };

  environment.systemPackages = let
    steam-run =  (pkgs.steam.override {
      extraLibraries = pkgs: with pkgs; [
        fuse
      ];
    }).run;
    in [
      steam-run
      pkgs.steamtinkerlaunch
    ];
}
