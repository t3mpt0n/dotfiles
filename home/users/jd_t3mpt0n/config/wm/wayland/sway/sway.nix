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
    checkConfig = false;
    config = {
      output = {
        "HDMI-A-1" = {
          mode = "1680x1050@60Hz";
          position = "0,320";
          background = "/home/jd/Media/Images/Wallpaper/1680x1050/Ginger Bread.jpg fill";
        };
        "DP-3" = {
          mode = "2560x1440@165Hz";
          position = "1680,0";
          adaptive_sync = "on";
          background = "/home/jd/Media/Images/Wallpaper/2560x1440/Beaver Pond.jpg fill";
        };
      };

      keybindings =
        let
          M = "${cfg.modifier}";
        in
        {
          # Programs
          "${M}+p" = "exec ${lib.getExe pkgs.wofi} --show run";
          "${M}+Shift+Return" = "exec ${lib.getExe' pkgs.emacs30-pgtk "emacsclient"} -c -e '(multi-vterm)'";
          "${M}+w" = "exec firefox";
          "${M}+Shift+S" = "exec ${lib.getExe pkgs.steam}";
          "${M}+Shift+D" = "exec ${lib.getExe pkgs.discord}";
        };

      startup = [
        { command = "systemctl --user restart waybar"; always = true; }
        { command = "${lib.getExe' pkgs.emacs30-pgtk "emacs"} --daemon"; }
        { command = "${lib.getExe pkgs.corectrl}"; }
        { command = "noisetorch"; }
      ];
    };
  };
}
