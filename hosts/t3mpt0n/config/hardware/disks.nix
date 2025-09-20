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
    initrd = {
      availableKernelModules = [
        "nvme"
        "cryptd"
      ];
    };
  };
}
