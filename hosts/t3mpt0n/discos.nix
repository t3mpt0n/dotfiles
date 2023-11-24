{
  config,
  pkgs,
  lib,
  ...
}: {
  environment.systemPackages = with pkgs; [
    btrfs-progs
    btrfs-snap
  ];

  boot = {
    loader.grub.enableCryptodisk = true;
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
      ssdopts = [ "noatime" "relatime" "compress=zstd" "ssd" "space_cache=v2" ]; # `space_cache=v2` -> btrfs exclusive.
      hddopts = [ "defaults" "noatime" "autodefrag" "compress=zstd" "commit=120" ];
    in {
      /* SSD */
      "/" = {
        device = "${fsdisk}";
        fsType = "${fisys}";
        options = ssdopts ++ [ "subvol=@" ];
      };
      "/home" = {
        device = "${fsdisk}";
        fsType = "${fisys}";
        options = ssdopts ++ [ "subvol=@home" ];
      };
      "/swap" = {
        device = "${fsdisk}";
        fsType = "${fisys}";
        options = ssdopts ++ [ "subvol=@swap" ];
      };
      "/tmp" = {
        device = "${fsdisk}";
        fsType = "${fisys}";
        options = ssdopts ++ [ "subvol=@tmp" ];
      };
      "/.snapshots" = {
        device = "${fsdisk}";
        fsType = "${fisys}";
        options = ssdopts ++ [ "subvol=@snapshots" ];
      };
      "/etc/nixos" = {
        device = "${fsdisk}";
        fsType = "${fisys}";
        options = ssdopts ++ [ "subvol=@nixconfig" ];
      };

      /* HDDs */
      "/mnt/dhp" = {
        device = "${bigdisk}";
        fsType = "${hddfs}";
        options = hddopts ++ [ "subvol=@" ];
      };
      "/mnt/dhp/.snapshots" = {
        device = "${bigdisk}";
        fsType = "${hddfs}";
        options = hddopts ++ [ "subvol=@snapshots" ];
      };
      "/mnt/dhp/Backups" = {
        device = "${bigdisk}";
        fsType = "${hddfs}";
        options = hddopts ++ [ "subvol=@backup" ];
      };
      "/mnt/dhp/media" = {
        device = "${bigdisk}";
        fsType = "${hddfs}";
        options = hddopts ++ [ "subvol=@media" ];
      };
    };
  swapDevices = [ { device = "/swap/swapfile"; } ];

  services = {
    btrfs.autoScrub = {
      enable = true;
      interval = "monthly";
      fileSystems = [ "/" ];
    };
    fstrim.enable = lib.mkDefault true;
  };

}
