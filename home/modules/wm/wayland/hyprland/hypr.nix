{
  pkgs,
  lib,
  config,
  ...
}: {
  wayland.windowManager.hyprland = {
    enable = lib.mkDefault false;
    portalPackage = pkgs.xdg-desktop-portal-hyprland;
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
      };
      animations.enabled = true;
      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];
      bind = let
        browser_setting = if config.custom.browser.chromium.brave.enable then "$mod, w, exec, ${lib.getExe pkgs.brave}"
        else if config.programs.firefox.enable then "$mod, w, exec, ${lib.getExe config.programs.firefox.package}" else "";
        in
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
          browser_setting
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
      exec-once = let
      in [
        "emacs --daemon"
        "corectrl"
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
