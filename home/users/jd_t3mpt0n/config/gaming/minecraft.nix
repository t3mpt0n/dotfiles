{
  pkgs,
  lib,
  config,
  ...
}: {
  home.packages = with pkgs; [
    (prismlauncher.override {
      additionalPrograms = [ pkgs.ffmpeg ];
      jdks = with pkgs; [
        zulu8
        zulu17
        zulu11
        zulu25
        zulu
      ];
    })
  ];
}
