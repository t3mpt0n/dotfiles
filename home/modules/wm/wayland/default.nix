{ pkgs, config, ... }:
{
  home = {
    sessionVariables = {
      SDL_VIDEODRIVER = "wayland";
      GDK_BACKEND = "wayland,x11";
      QT_QPA_PLATFORM = "wayland;xcb";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
      _JAVA_AWT_WM_NONREPARENTING = "1";
      XDG_SESSION_TYPE = "wayland";
      QT_AUTO_SCREEN_SCALE_FACTOR = "1";
      MOZ_ENABLE_WAYLAND = "1";
    };

    packages = with pkgs; [
      imv
      grim
      slurp
    ];
  };

  wayland.systemd.target =
    if config.wayland.windowManager.sway.enable then
      "sway-session.target"
    else
      "graphical-session.target";
}
