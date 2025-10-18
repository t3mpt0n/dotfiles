{ pkgs, ... }:
{
  services.dbus = {
    enable = true;
    packages = with pkgs; [
      gcr
    ];
  };

  security.rtkit.enable = true;

  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    configPackages = [ pkgs.hyprland ];
    extraPortals = with pkgs; [
      xdg-desktop-portal-hyprland
      xdg-desktop-portal-gtk
    ];
  };
}
