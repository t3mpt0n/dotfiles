{ pkgs, lib, ... }:
{
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    systemd.enable = true;
    settings = {
      "$mod" = "SUPER";
      general = {
        gaps_in = 5;
        gaps_out = 3;
        border_size = 2;
        resize_on_border = true;
        allow_tearing = true;
        col = {
          active_border = "rgb(255, 140, 0)";
          inactive_border = "rgb(171, 178, 185)";
        };
      };
      bind =
        (builtins.concatLists (
          builtins.genList (
            i:
            let
              ws = i + 1;
            in
            [
              "$mod, code:1${toString i}, workspace, ${toString ws}"
              "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
            ]
          ) 9
        ))
        ++ [
          "$mod, h, movefocus, l"
          "$mod, j, movefocus, d"
          "$mod, k, movefocus, u"
          "$mod, l, movefocus, r"
          "$mod SHIFT, h, movewindow, l"
          "$mod SHIFT, j, movewindow, d"
          "$mod SHIFT, k, movewindow, u"
          "$mod SHIFT, l, movewindow, r"
          ", XF86AudioLowerVolume, exec, ${lib.getExe' pkgs.alsa-utils "amixer"} sset Master 5%-"
          ", XF86AudioRaiseVolume, exec, ${lib.getExe' pkgs.alsa-utils "amixer"} sset Master 5%+"
          ", XF86AudioMute, exec, ${lib.getExe' pkgs.alsa-utils "amixer"} sset Master toggle"
        ];
    };
  };
}
