{
  config,
  lib,
  pkgs,
  ...
}: {
  programs.gzdoom = {
    enable = true;
    DOOMWADDIR = "/home/jd/Games/DOOM";
  };
}
