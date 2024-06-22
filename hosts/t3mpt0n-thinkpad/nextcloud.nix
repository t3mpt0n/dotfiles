{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib.modules) mkIf;
in {
  services = {
    postgresql = {
      enable = true;
      ensureDatabases = [ "nextcloud" ];
      ensureUsers = [
        {
          name = "nextcloud";
          ensureDBOwnership = true;
        }
      ];
    };

    nextcloud = {
      enable = true;
      hostName = "nextcloud.t3mpt0n.com";

      package = pkgs.nextcloud29;

      database.createLocally = true;
      configureRedis = true;

      maxUploadSize = "4G";
      https = true;

      config = {
        dbtype = "pgsql";
        dbhost = "/run/postgresql";
        dbname = "nextcloud";
        adminuser = "Sydster";
        adminpassFile = config.age.secrets.nextcloud_admin.path;
      };

      settings = {
        overwriteprotocol = "https";
        trusted_domains = [ config.services.nextcloud.hostName "192.168.1.190" ];
      };
    };

    nginx.virtualHosts."nextcloud.t3mpt0n.com" = {
      forceSSL = true;
      enableACME = true;
      acmeRoot = null;
    };
  };

  systemd.services."nextcloud-setup" = {
    requires = [ "postgresql.service" ];
    after = [ "postgresql.service" ];
  };
}
  
