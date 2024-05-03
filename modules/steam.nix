{
  config,
  lib,
  pkgs,
  ...
}: {
  programs = {
    steam = {
      enable = true;
    };

    gamescope = {
      enable = true;
      args = [
        "--hdr-enabled"
        "-W 2560"
        "-H 1440"
        "-w 2560"
        "-h 1440"
      ];
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
