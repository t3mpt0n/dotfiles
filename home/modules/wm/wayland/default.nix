{ pkgs, config, ... }:
{
  home = {
    sessionVariables = {
      SDL_VIDEODRIVER = "wayland";
      GDK_BACKEND = "wayland";
      QT_QPA_PLATFORM = "wayland;xcb";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
      _JAVA_AWT_WM_NONREPARENTING = "1";
      XDG_SESSION_TYPE = "wayland";
      QT_AUTO_SCREEN_SCALE_FACTOR = "1";
      MOZ_ENABLE_WAYLAND = "1";
      NIXOS_OZONE_WL = "1";
    };

    packages = with pkgs; [
      imv
      grim
      slurp
    ];
  };

  services.gnome-keyring.enable = true;
}
