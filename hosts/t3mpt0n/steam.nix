{
  pkgs,
  lib,
  config,
  ...
}: {
  programs.steam = {
    enable = true;
  };

  environment.systemPackages = [
    pkgs.gamemode
  ];
}
