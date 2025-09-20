{
  pkgs,
  lib,
  ...
}:
{
  services.zfs = {
    trim.enable = true;
    autoScrub.enable = true;
  };
  boot = {
    loader.systemd-boot.enable = true;
    supportedFilesystems = [ "zfs" ];
    initrd = {
      availableKernelModules = [
        "nvme"
        "cryptd"
        "zfs"
      ];
      luks.devices = {
        "cryptswap" = {
          device = "/dev/disk/by-uuid/167bffed-20e7-488c-a54e-e048248486c3";
          allowDiscards = true;
        };
        "cryptzfs" = {
          device = "/dev/disk/by-uuid/cc508dc7-9642-4623-a6d9-c6e0f56d48bb";
          allowDiscards = true;
        };
      };
    };
  };
}
