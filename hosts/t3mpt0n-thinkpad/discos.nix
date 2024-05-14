{
  config,
  lib,
  pkgs,
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
        "thinkpad".device = "75923059-1586-4242-8bf9-89a38303847d";
      };
    };
  };

  fileSystems =
    let
      fHDD = ({ dev ? "/dev/disk/by-uuid/d98eec5e-2002-4190-b517-8646ccaafe0a"
              , fs ? "btrfs"
              , subvol ? "@"
              , extraOpts ? []
              , opts ? [ "defaults" "noatime" "autodefrag" "compress=zstd" "commit=120" "subvol=${subvol}" ] ++ extraOpts }: {
                device = dev;
                fsType = fs;
                options = opts;
              });
    in {
      "/" = fHDD;
      "/home" = fHDD { subvol = "@home"; };
      "/swap" = fHDD { subvol = "@swap"; };
      "/tmp" = fHDD { subvol = "@tmp"; };
      "/nix" = fHDD { subvol = "@nix"; };
      "/etc/nixos" = fHDD { subvol = "@nixconf"; };
      swapDevices = [ { device = "/swap/swapfile"; } ];
    };

  services = {
    btrfs.autoScrub = {
      enable = true;
      interval = "monthly";
      fileSystems = [ "/" ];
    };
    udisks2.enable = true;
  };
}
