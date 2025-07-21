{
  pkgs,
  lib,
  ...
}:
{
  home.packages = with pkgs; [
    xdg-desktop-portal-wlr
    xdg-desktop-portal-hyprland
    xdg-desktop-portal-gtk
    kdePackages.xdg-desktop-portal-kde
  ];
  xdg.portal = {
    xdgOpenUsePortal = true;
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-wlr
      xdg-desktop-portal-hyprland
      xdg-desktop-portal-gtk
      kdePackages.xdg-desktop-portal-kde
    ];
  };
  xdg.desktopEntries = {
    Thunar = {
      name = "Thunar";
      genericName = "File Explorer";
      exec = "Thunar %U";
      terminal = false;
      mimeType = [ "inode/directory" ];
    };
  };
  xdg.mime.enable = true;
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "x-scheme-handler/https" = [ "floorp.desktop" ];
      "x-scheme-handler/http" = [ "floorp.desktop" ];
      "inode/directory" = [ "Thunar.desktop" ];
    };
  };
}
