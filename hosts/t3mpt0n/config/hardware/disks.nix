{
  pkgs,
  lib,
  ...
}:
{
  services.btrfs = {
    autoScrub = {
      enable = true;
      interval = "monthly";
      fileSystems = [ "/" "/home" ];
    };
  };
  boot = {
    loader.systemd-boot.enable = true;
    initrd = {
      availableKernelModules = [
        "cryptd"
      ];
    };
  };
}
