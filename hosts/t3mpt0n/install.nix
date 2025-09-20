{
  disko.devices = {
    disk = {
      bare_1TB = {
        type = "disk";
        device = "/dev/nvme1n1";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              size = "1024M";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [ "umask=0077" ];
              };
            };
            cryptbutter = {
              size = "100%";
              content = {
                type = "luks";
                name = "cryptzfs";
                settings = {
                  allowDiscards = true;
                };
                content = {
                  type = "btrfs";
                  extraArgs = [ "-f" ];
                  subvolumes = let
                    ssdMountOpt = [
                      "noatime"
                      "relatime"
                      "compress=zstd"
                      "ssd"
                      "space_cache=v2"
                    ];
                  in {
                    "@nixos-root" = {
                      mountpoint = "/";
                      mountOptions = ssdMountOpt;
                    };
                    "@nixos-sysconf" = {
                      mountpoint = "/etc/nixos";
                      mountOptions = ssdMountOpt;
                    };
                    "@nixos-nixstore" = {
                      mountpoint = "/nix";
                      mountOptions = ssdMountOpt;
                    };

                    "@linux-home" = {
                      mountpoint = "/home";
                      mountOptions = ssdMountOpt;
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
}
