{
  lib,
  ...
}: let
  bootdrv = "/dev/nvme0n1";
  efimnt = "/boot";
  in {
  disko.devices = {
    disk = {
      ideapad_hdd = {
        type = "disk";
        device = bootdrv;
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              priority = 1;
              size = "512M";
              name = "ESP";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = efimnt;
              };
            };
            butterluks = {
              size = "100%";
              content = {
                type = "luks";
                name = "yogapad";
                content = {
                  type = "btrfs";
                  subvolumes = let
                    commOpts = [ "noatime" "relatime" "ssd" "compress=zstd" "commit=120" "space_cache=v2" ];
                  in {
                    "@" = {
                      mountpoint = "/";
                      mountOptions = commOpts;
                    };
                    "@home" = {
                      mountpoint = "/home";
                      mountOptions = commOpts;
                    };
                    "@tmp" = {
                      mountpoint = "/tmp";
                      mountOptions = commOpts;
                    };
                    "@nix" = {
                      mountpoint = "/nix";
                      mountOptions = commOpts;
                    };
                    "@nixconf" = {
                      mountpoint = "/etc/nixos";
                      mountOptions = commOpts;
                    };
                    "@swap" = {
                      mountpoint = "/swap";
                      swap.swapfile.size = "16G";
                    };
                  };
                };
              };
            };
          };
        };
      };
    };
  };

  boot.loader  = {
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = efimnt;
    };
    grub = {
      enable = true;
      efiSupport = true;
      device = "nodev";
      extraEntries = ''
      menuentry "Reboot" {
        reboot
      }
      menuentry "Poweroff" {
        halt
      }
    '';
    };
  };
}
