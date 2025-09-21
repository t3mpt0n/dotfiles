{
  disko.devices = {
    disk = {
      hetzner_40G = {
        type = "disk";
        device = "/dev/sda";
        content = {
          type = "gpt";
          partitions = {
            boot = {
              size = "1M";
              type = "EF02";
              attributes = [ 0 ];
            };

            cryptroot = {
              size = "100%";
              content = {
                type = "luks";
                name = "cryptroot";
                content = {
                  type = "btrfs";
                  extraArgs = [ "-f" ];
                  subvolumes = let
                    mopt = [
                      "noatime"
                      "relatime"
                      "compress=zstd"
                      "space_cache=v2"
                    ];
                  in {
                    "@hetzner-root" = {
                      mountpoint = "/";
                      mountOptions = mopt;
                    };

                    "@hetzner-nixstore" = {
                      mountpoint = "/nix";
                      mountOptions = mopt;
                    };

                    "@swap" = {
                      mountpoint = "/swap";
                      swap.swapfile.size = "4G";
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
