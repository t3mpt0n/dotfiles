{
  config,
  lib,
  pkgs,
  ...
}: {
  programs.plasma = {
    enable = true;
  };

  home.packages = with pkgs.kdePackages; [
    plasma-desktop
    plasma-workspace
    plasma-wayland-protocols
    systemsettings
    plasma-integration
  ];
}
