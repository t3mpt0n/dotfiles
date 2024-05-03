{
  pkgs,
  lib,
  ...
}: {
  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      obs-vkcapture
      wlrobs
      pkgs.xwaylandvideobridge
      obs-pipewire-audio-capture
      input-overlay
    ];
  };
}
