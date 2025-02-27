{
  pkgs,
  lib,
  ...
}: {
  wayland.windowManager.hyprland = {
    settings = {
      monitor = [
        "HDMI-A-1, 1680x1050@60, 0x320, 1"
        "DP-3, 2560x1440@165, 1680x0, 1, vrr, 1"
      ];
      bind = [
        "$mod, p, exec, ${lib.getExe pkgs.wofi} --show run"
        "$mod SHIFT, Return, exec, ${lib.getExe pkgs.kitty}"
        "$mod, w, exec, ${lib.getExe pkgs.floorp}"
        "$mod SHIFT, S, exec, ${lib.getExe pkgs.steam}"
        "$mod SHIFT, D, exec, ${lib.getExe pkgs.discord}"
        "$mod SHIFT, E, exec, ${lib.getExe' pkgs.emacs30-pgtk "emacsclient"} -c"
      ];

      exec-once = ["${lib.getExe pkgs.waybar}"];
    };
  };
}
