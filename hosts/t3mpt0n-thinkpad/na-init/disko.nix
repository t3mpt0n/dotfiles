{
  lib,
  ...
}: {
  disko.devices = {
    disk = {
      thinkpad_hdd = {
        type = "disk";
        device = "/dev/sda";
        content = {
          type = "gpt";
          partitions = {
            bootflag = {
              size = "1M";
              type = "EF02";
              priority = 1;
            };
            boot = {
              size = "512M";
              type = "8300";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
              };
            };
            butterluks = {
              size = "100%";
              content = {
                type = "luks";
                name = "thinkpad";
                content = {
                  type = "btrfs";
                  subvolumes = let
                    commOpts = [ "defaults" "noatime" "autodefrag" "compress=zstd" "commit=120" ];
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
                      swap.swapfile.size = "8G";
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

  boot.loader.grub = {
    efiSupport = false;
  };
}
