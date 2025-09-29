{ pkgs, lib, ... }:
{
  wayland.windowManager.hyprland = {
    settings = {
      monitor = [
        "eDP-1, 1920x1080@60, 0x0, 1"
      ];
      bind = [
        "$mod SHIFT, Return, exec, ${lib.getExe pkgs.kitty}"
        "$mod, w, exec, ${lib.getExe pkgs.firefox}"
        "$mod SHIFT, S, exec, ${lib.getExe pkgs.steam}"
        "$mod SHIFT, D, exec, ${lib.getExe pkgs.discord}"
        "$mod SHIFT, E, exec, ${lib.getExe' pkgs.emacs30-pgtk "emacsclient"} -c "
      ];

      exec-once = [ "${lib.getExe pkgs.waybar}" ];
    };
  };
}
