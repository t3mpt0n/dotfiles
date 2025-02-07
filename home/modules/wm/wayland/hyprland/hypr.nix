{ pkgs, lib, ... }:
{
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    systemd = {
      enable = true;
      extraCommands = [
        "systemctl --user reset-failed"
        "systemctl --user stop hyprland-session.target"
        "systemctl --user start hyprland-session.target"
        "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1"
      ];
    };
    settings = {
      "$mod" = "SUPER";
      general = {
        gaps_in = 5;
        gaps_out = 3;
        border_size = 2;
        resize_on_border = true;
        allow_tearing = true;
        "col.active_border" = "rgb(ff8c00)";
        "col.inactive_border" = "rgb(abb2b9)";
      };

      animations.enabled = true;
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

  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = "on";
      splash = false;
    };
  };
}
