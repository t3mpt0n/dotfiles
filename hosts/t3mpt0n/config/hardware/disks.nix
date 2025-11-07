{
  pkgs,
  lib,
  config,
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
      
      luks.devices = {
        "bigdata0".device = "/dev/disk/by-uuid/dcf4709c-1cda-4e95-93fb-4fa85c28b817";
        "bigdata1".device = "/dev/disk/by-uuid/d798f228-85c8-4e97-86e1-71a09c4cf535";
      };
    };
  };

  fileSystems =
    let
      hddopts = [
        "defaults"
        "noatime"
        "autodefrag"
        "commit=120"
      ];

      ssdopts = [
        "noatime"
        "relatime"
      ];

      fSSD = {
        dev ? "/dev/disk/by-uuid/8762427e-f243-444d-855c-0196cba7de9a",
        fs ? "btrfs",
        subvol ? "@",
        opts ? ssdopts ++ [ "subvol=${subvol}" "space_cache=v2" "compress=zstd" "ssd" ],
      }: {
        device = dev;
        fsType = fs;
        options = opts;
      };

      fHDD = {
        dev ? "/dev/disk/by-uuid/97172088-55f5-4c4a-9cff-0ca5243dca18",
        fs ? "btrfs",
        subvol ? "@",
        opts ? hddopts ++ [ "subvol=${subvol}" "compress=zstd" ],
      }: {
        device = dev;
        fsType = fs;
        options = opts;
      };
    in {
      #      "/data/fast/games" = fSSD { subvol = "@games"; };
      "/data/fast" = {
        device = "/dev/disk/by-uuid/d4735cfb-06a0-4e34-92a0-e275c99de250";
        fsType = "ext4";
        options = ssdopts;
      };
      "/data/big/music" = fHDD { subvol = "@music"; };
      "/data/big/roms" = fHDD { subvol = "@roms"; };
      "/data/big/pictures" = fHDD { subvol = "@pictures"; };
      "/data/big/videos" = fHDD { subvol = "@videos"; };
    };
  systemd.tmpfiles.rules = [
    "d /data/fast 0755 jd users"
    "d /data/big/music 0755 jd users"
    "d /data/big/roms 0755 jd users"
    "d /data/big/pictures 0755 jd users"
    "d /data/big/videos 0755 jd users"
    # "d /data/fast/games 0755 jd users"
  ];

  services.udisks2.enable = true;
}
