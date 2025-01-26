{
  disko.devices = {
    disk = {
      al_ssd = {
        type = "disk";
        device = "/dev/nvme0n1";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              priority = 1;
              name = "ESP";
              size = "512M";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [ "umask=0077" ];
              };
            };

            root = {
              size = "100%";
              content = {
                type = "luks";
                name = "laptop";
                content = {
                  type = "btrfs";
                  extraArgs = [ "-f" ];
                  subvolumes =
                    let
                      ssdopts = [
                        "noatime"
                        "relatime"
                        "compress=zstd"
                        "ssd"
                        "space_cache=v2"
                      ];
                    in
                    {
                      "@" = {
                        mountpoint = "/";
                        mountOptions = ssdopts;
                      };
                      "@home" = {
                        mountOptions = ssdopts;
                        mountpoint = "/home";
                      };
                      "@nix" = {
                        mountOptions = ssdopts;
                        mountpoint = "/nix";
                      };
                      "@nixconf" = {
                        mountOptions = ssdopts;
                        mountpoint = "/etc/nixos";
                      };
                      "@tmp" = {
                        mountOptions = ssdopts;
                        mountpoint = "/tmp";
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
