{
  pkgs,
  lib,
  ...
}: {
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      monitor = [
        "HDMI-A-1, 1680x1050@60, 0x320, 1"
        "DP-3, 2560x1440@165, 1680x0, 1, vrr, 1"
      ];
      bind = [
        "$mod SHIFT, Return, exec, ${lib.getExe' pkgs.emacs-pgtk "emacsclient"} -c -e '(vterm (random))'"
        "$mod SHIFT, S, exec, ${lib.getExe pkgs.steam}"
        "$mod SHIFT, D, exec, ${lib.getExe pkgs.vesktop}"
      ];

      exec-once = ["${lib.getExe pkgs.waybar}"];
    };
  };
}
