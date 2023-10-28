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
      obs-pipewire-audio-capture
      input-overlay
    ];
  };
}
