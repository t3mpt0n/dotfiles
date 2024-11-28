{ config, pkgs, lib, self, ...}:
{
  imports = [
    ./sway.nix
    ./wofi.nix
    ./waybar.nix
    ./hypr.nix
  ];

  home = {
    sessionVariables = {
      SDL_VIDEODRIVER = "wayland";
      GDK_BACKEND="wayland,x11";
      QT_QPA_PLATFORM = "wayland;xcb";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
      _JAVA_AWT_WM_NONREPARENTING = "1";
      XDG_SESSION_TYPE = "wayland";
      QT_AUTO_SCREEN_SCALE_FACTOR="1";
      MOZ_ENABLE_WAYLAND = "1";
      XDG_DATA_DIRS = "/var/lib/flatpak/exports/share:$HOME/.local/share/flatpak:$XDG_DATA_DIRS";
    };

    packages = with pkgs; [
      imv
      grim
      slurp
      wl-clipboard
      wlr-randr
      wlogout
      xorg.libX11
      wineWowPackages.waylandFull
      xwayland
    ];
  };
}
