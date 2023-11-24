{
  pkgs,
  lib,
  config,
  ...
}: {
  environment.systemPackages = [
    pkgs.nextcloud-client
  ];
}
