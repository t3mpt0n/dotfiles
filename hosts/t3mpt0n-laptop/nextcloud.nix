{
  pkgs,
  config,
  lib,
  ...
}: {
  services = {
    nextcloud = {
      enable = true;
      package = pkgs.nextcloud27;
      extraApps = with config.services.nextcloud.package.packages.apps; {
        inherit news calendar bookmarks twofactor_nextcloud_notification tasks files_texteditor keeweb;
      };
      hostName = "nextcloud.t3mpt0n.com";
      https = true;
      configureRedis = true;
      config = {
        adminpassFile = config.age.secrets.nextcloud.path;
        overwriteProtocol = "https";
        dbtype = "mysql";
        dbname = "nextcloud";
        adminuser = "Sydney";
        extraTrustedDomains = [ "192.168.1.200" ];
      };
    };

    nginx.virtualHosts."nextcloud.t3mpt0n.com" = {
      forceSSL = true;
      enableACME = true;
    };

    mysql = {
      ensureDatabases = [ "nextcloud" ];
      ensureUsers = [
        { name = "nextcloud"; ensurePermissions."nextcloud.*" = "ALL PRIVILEGES";}
      ];
    };
  };

  systemd.services."nextcloud-setup" = {
    requires = ["mysql.service"];
    after = ["mysql.service"];
  };
}
