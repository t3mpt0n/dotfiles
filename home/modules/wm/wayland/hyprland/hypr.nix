{
  pkgs,
  lib,
  config,
  ...
}: {
  wayland.windowManager.hyprland = {
    enable = lib.mkDefault false;
    xwayland.enable = true;
    systemd = {
      enable = true;
      variables = ["--all"];
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
      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];
      bind =
        (builtins.concatLists (
          builtins.genList (
            i: let
              ws = i + 1;
            in [
              "$mod, code:1${toString i}, workspace, ${toString ws}"
              "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
            ]
          )
          9
        ))
        ++ [
          "$mod, p, exec, ${lib.getExe pkgs.fuzzel}"
          "$mod, e, exec, ${lib.getExe' pkgs.emacs-pgtk "emacsclient"} -c -a 'emacs'"
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
          "$mod SHIFT, q, killactive,"
          "$mod, f, fullscreen"
        ];
      env = [
        "XDG_CURRENT_DESKTOP,Hyprland"
      ];
      exec-once = [
        "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
        "sleep 4"
        "killall -e xdg-desktop-portal-hyprland"
        "killall xdg-desktop-hyprland"
        "${lib.getExe pkgs.xdg-desktop-portal-hyprland} &"
        "sleep 4"
        "${lib.getExe pkgs.xdg-desktop-portal} &"
      ];
    };
  };

  home.sessionVariables =
    if config.wayland.windowManager.hyprland.enable
    then {
      XDG_CURRENT_DESKTOP = "Hyprland";
      XDG_SESSION_DESKTOP = "Hyprland";
    }
    else {};

  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = "on";
      splash = false;
    };
  };
}
