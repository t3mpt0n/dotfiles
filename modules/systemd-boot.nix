{
  pkgs,
  lib,
  ...
}: {
  boot.loader.systemd-boot.enable = true;
}
