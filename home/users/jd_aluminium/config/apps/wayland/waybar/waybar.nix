{
  lib,
  config,
  pkgs,
  ...
}:
{
  programs.waybar = {
    settings = {
      mainBar = {
        modules-right = [
          "battery"
          "network"
          "cpu"
          "memory"
          "pulseaudio"
          "tray"
        ];
        "battery" = {
          bat = "BAT0";
          interval = 15;
          states = {
            "warning" = 25;
            "critical" = 10;
          };
          format = "{capacity}% {icon}";
        };
      };
    };
  };
}
