{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.wayland.windowManager.sway.config;
in
{
  wayland.windowManager.sway = {
    config = {
      output = {
        "HDMI-A-1" = {
          mode = "1680x1050@60Hz";
          position = "0,320";
        };
        "DP-3" = {
          mode = "2560x1440@165Hz";
          position = "1680,0";
          adaptive_sync = "on";
        };
      };

      keybindings =
        let
          M = "${cfg.modifier}";
        in
        {
          # Programs
          "${M}+p" = "exec ${lib.getExe pkgs.wofi} --show run";
          "${M}+Shift+Return" = "exec ${lib.getExe pkgs.kitty}";
          "${M}+w" = "exec ${lib.getExe pkgs.floorp}";
          "${M}+Shift+S" = "exec ${lib.getExe pkgs.steam}";
          "${M}+Shift+D" = "exec ${lib.getExe pkgs.discord}";
        };

      startup = [
        "${lib.getExe pkgs.wpaperd}"
      ];
    };
  };
}
