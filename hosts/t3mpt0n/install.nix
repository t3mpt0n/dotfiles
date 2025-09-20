{
  pkgs,
}: {
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
            cryptswap = {
              size = "16G";
              content = {
                type = "luks";
                name = "cryptswap";
                settings = {
                  allowDiscards = true;
                };
                content = {
                  type = "swap";
                  mountpoint = "swap";
                  
                  discardPolicy = "both";
                  resumeDevice = false;
                };
              };
            };
            cryptzfs = {
              size = "100%";
              content = {
                type = "luks";
                name = "cryptzfs";
                settings = {
                  allowDiscards = true;
                };
                content = {
                  type = "zfs";
                  pool = "syspool";
                };
              };
            };
          };
        };
      };

      zpool = {
        syspool = {
          type = "zpool";
          options = {
            ashift = "12";
            autotrim = "on";
            compatibility = "openzfs-2.1-linux";
          };
          rootFsOptions = {
            acltype = "posixacl";
            xattr = "sa";
            realtime = "on";
            compression = "lz4";
          };

          datasets = {
            "NixOS" = {
              type = "zfs_fs";
              options.mountpoint = "none";
              mountpoint = "none";
            };

            "LinuxHome" = {
              type = "zfs_fs";
              options = {
                mountpoint = "/home";
              };
              mountpoint = "/home";
            };

            "NixOS/ROOT" = {
              type = "zfs_fs";
              options = {
                canmount = "noauto";
                mountpoint = "/";
              };
              mountpoint = "/";
            };
            "NixOS/ROOT/NIX" = {
              type = "zfs_fs";
              options = {
                canmount = "on";
                mountpoint = "/nix";
              };
            };
            "NixOS/ROOT/SYSCONF" = {
              type = "zfs_fs";
              options = {
                canmount = "on";
                mountpoint = "/etc/nixos";
              };
            };
          };
        };
      };
    };
  };
}
