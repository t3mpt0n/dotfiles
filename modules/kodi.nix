{
  config,
  lib,
  pkgs,
  ...
}: {
  users.extraUsers.kodi.isNormalUser = true;
  nixpkgs.config.kodi.enableAdvancedLauncher = true;
  environment.systemPackages = [
    pkgs.kodi-wayland
  ];
}
