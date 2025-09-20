{
  pkgs,
  lib,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    btrfs-progs
    btrfs-snap
  ];

  boot = {
    initrd = {
      availableKernelModules = [
        "cryptd"
      ];
      luks.devices = {
        "stick0" = {
          device = "/dev/disk/by-uuid/39af3d4f-05a1-467f-9a5f-326e78f8ad51";
          allowDiscards = true;
        };
        "stick1" = {
          device = "/dev/disk/by-uuid/880d844d-9891-47df-9589-e3595604d6e8";
          allowDiscards = true;
        };
        "bfd0".device = "/dev/disk/by-uuid/beeaf9d4-3027-45cc-93a4-4412f6256be7";
        "bfd1".device = "/dev/disk/by-uuid/72cb8de2-3aba-4a9c-92d1-44a19c69bec4";
      };
    };
  };

  fileSystems =
    let
      fsdisk = "/dev/disk/by-uuid/4765ece6-5cda-4ef0-ba1f-0a83017a9c74";
      bigdisk = "/dev/disk/by-uuid/20ae7037-8594-4de3-93dc-95c49d08a9fb";
      hddfs = "btrfs";
      fisys = "btrfs";
      ssdopts = [
        "noatime"
        "relatime"
        "compress=zstd"
        "ssd"
        "space_cache=v2"
      ]; # `space_cache=v2` -> btrfs exclusive.
      hddopts = [
        "defaults"
        "noatime"
        "autodefrag"
        "compress=zstd"
        "commit=120"
      ];
      fSSD = (
        {
          dev ? "/dev/disk/by-uuid/4765ece6-5cda-4ef0-ba1f-0a83017a9c74",
          fs ? "btrfs",
          subvol ? "@",
          opts ? ssdopts ++ [ "subvol=${subvol}" ],
        }:
        {
          device = dev;
          fsType = fs;
          options = opts;
        }
      );
      fHDD = (
        {
          dev ? "/dev/disk/by-uuid/20ae7037-8594-4de3-93dc-95c49d08a9fb",
          fs ? "btrfs",
          subvol ? "@",
          opts ? hddopts ++ [ "subvol=${subvol}" ],
        }:
        {
          device = dev;
          fsType = fs;
          options = opts;
        }
      );
    in
    {
      # SSD
      "/" = fSSD { subvol = "@"; };
      "/home" = fSSD { subvol = "@home"; };
      "/swap" = fSSD { subvol = "@swap"; };
      "/tmp" = fSSD { subvol = "@tmp"; };
      "/nix" = fSSD { subvol = "@nix"; };
      "/etc/nixos" = fSSD { subvol = "@nixconfig"; };

      ## Games
      "/home/jd/Games" = fSSD { subvol = "@home/jd/.local/@games"; };

      # HDDs
      "/mnt/dhp" = fHDD { subvol = "@"; };
      "/mnt/dhp/.snapshots" = fHDD { subvol = "@snapshots"; };
      "/mnt/dhp/Backups" = fHDD { subvol = "@backup"; };
      "/mnt/dhp/media" = fHDD { subvol = "@media"; };
    };
  swapDevices = [ { device = "/swap/swapfile"; } ];

  services = {
    btrfs.autoScrub = {
      enable = true;
      interval = "monthly";
      fileSystems = [ "/" ];
    };
    fstrim.enable = lib.mkDefault true;
    udisks2.enable = true;
  };

}
