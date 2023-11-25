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
        "stick" = {
          device = "/dev/disk/by-uuid/39af3d4f-05a1-467f-9a5f-326e78f8ad51";
          allowDiscards = true;
        };
      };
    };
  };

  fileSystems =
    let
      fsdisk = "/dev/disk/by-uuid/2d1ff13c-1000-4b6e-93cd-a6973509dc2a";
      fisys = "btrfs";
      ssdopts = [ "noatime" "relatime" "compress=zstd" "ssd" "space_cache=v2" ]; # `space_cache=v2` -> btrfs exclusive.
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
