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
    config = rec {
      output = {
        "eDP-1" = {
          mode = "1920x1080@60Hz";
        };
      };

      keybindings =
        let
          M = "${cfg.modifier}";
        in
        {
          "${M}+p" = "exec ${lib.getExe pkgs.wofi} --show run";
          "${M}+Shift+Return" = "exec ${lib.getExe pkgs.kitty}";
          "${M}+w" = "exec ${lib.getExe pkgs.floorp}";
          "${M}+Shift+D" = "exec ${lib.getExe pkgs.discord}";
        };
    };
  };
}
