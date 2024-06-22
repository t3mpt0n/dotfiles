{
  config,
  lib,
  pkgs,
  ...
}: {
  home.packages = with pkgs.kdePackages; [
    plasma-desktop
    plasma-integration
    plasma-wayland-protocols
    libplasma
    breeze
    systemsettings
  ];
}
