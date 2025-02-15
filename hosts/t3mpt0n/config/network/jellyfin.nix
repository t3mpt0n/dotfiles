{ pkgs, lib, ... }:
{
  services.jellyfin = {
    enable = true;
    openFirewall = true;
  };
  environment.systemPackages = [
    pkgs.jellyfin-ffmpeg
    pkgs.jellyfin-web
  ];
}
