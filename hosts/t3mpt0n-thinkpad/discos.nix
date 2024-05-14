{
  config,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    btrfs-progs
    btrfs-snap
  ];

  boot = {
    loader.grub = {
      enableCryptodisk = true;
      devices = [ "/dev/disk/by-uuid/0B32-A171" ]; # Boot Device
    };
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
      devv = "/dev/disk/by-uuid/d98eec5e-2002-4190-b517-8646ccaafe0a";
      hddopts = [ "defaults" "noatime" "autodefrag" "compress=zstd" "commit=120" ];
    in {
      "/" = {
        device = devv;
        fsType = "btrfs";
        options = hddopts ++ [ "subvol=@" ];
      };
      "/home" = {
        device = devv;
        fsType = "btrfs";
        options = hddopts ++ [ "subvol=@home" ];
      };
      "/nix" = {
        device = devv;
        fsType = "btrfs";
        options = hddopts ++ [ "subvol=@nix" ];
      };
      "/swap" = {
        device = devv;
        fsType = "btrfs";
        options = hddopts ++ [ "subvol=@swap" ];
      };
      "/etc/nixos" = {
        device = devv;
        fsType = "btrfs";
        options = hddopts ++ [ "subvol=@nixconf" ];
      };
      "/tmp" = {
        device = devv;
        fsType = "btrfs";
        options = hddopts ++ [ "subvol=@tmp" ];
      };
    };
  swapDevices = [ { device = "/swap/swapfile"; } ];

  services = {
    btrfs.autoScrub = {
      enable = true;
      interval = "monthly";
      fileSystems = [ "/" ];
    };
    udisks2.enable = true;
  };
}
