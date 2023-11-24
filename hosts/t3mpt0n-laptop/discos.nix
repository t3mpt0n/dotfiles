{
  config,
  pkgs,
  lib,
  ...
}: {
  services.lvm2 = {
    enable = true;
  };

  boot = {
    loader.grub.enableCryptodisk = true;
    initrd = {
      availableKernelModules = [
        "cryptd"
        "lvm"
      ];
      luks.devices = {
        "cryptlvm" = {
          device = "/dev/disk/by-uuid/ef6af3e5-1d46-4b0a-9a82-6a8e5dd7e4fc";
          allowDiscards = true;
        };
      };
    };
  };

  filesystems = let
    nix-root = "/dev/disk/by-uuid/b3d11caa-19dc-4f7d-a7a6-4910dd2f97c9";
    nix-home = "/dev/disk/by-uuid/5ca06827-a870-4c7d-8791-4f3b8a5fdd27";
    ssdopts = [ "noatime" "relatime" "compress=zstd" "ssd" ];
    fisys = "ext4";
  in {
    "/" = {
      device = nix-root;
      fsType = fisys;
      options = ssdopts;
    };
    "/home" = {
      device = nix-home;
      fsType = fisys;
      options = ssdopts;
    };
  };
  swapDevices = [ { device = "/dev/disk/by-uuid/788b70b6-b8cd-449a-8fc0-7686b01dc4fd"; } ];
}
