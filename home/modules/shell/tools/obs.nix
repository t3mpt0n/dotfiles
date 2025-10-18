{
  lib,
  config,
  pkgs,
  ...
}: {
  programs.obs-studio = {
    enable = lib.mkDefault false;
    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
    ];
  };
}
