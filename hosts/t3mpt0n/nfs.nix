{
  config,
  lib,
  pkgs,
  ...
}: {
  services = {
    davfs2 = {
      enable = true;
      extraConfig = ''
        use_locks 0
      '';
    };
  };
  users.users.jd.extraGroups = [ "davfs2" ];

  fileSystems = {
    "/home/jd/Nextcloud" = {
      device = "https://nextcloud.t3mpt0n.com/remote.php/dav/files/jd";
      fsType = "davfs";
      options = [ "user" "rw" "auto" ];
    };
  };
}
