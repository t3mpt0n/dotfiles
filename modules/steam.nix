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
}
