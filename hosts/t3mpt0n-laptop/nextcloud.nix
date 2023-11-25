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
      hostName = "nextcloud.t3mpt0n.com";
      https = true;
      nginx.enable = true;
      database.createLocally = true;
      configureRedis = true;
      config = {
        adminpassFile = config.age.secrets.nextcloud.path;
        overwriteProtocol = "https";
        dbuser = "jd";
        dbname = "nextcloud";
        dbpassFile = config.age.secrets.nextcloud_jd.path;
        dbtype = "pgsql";
        dbport = 800;
        dbhost = "/run/postgresql";
        adminuser = "admin";
      };
    };

    nginx = {
      enable = true;

      recommendedGzipSettings = true;
      recommendedOptimisation = true;
      recommendedProxySettings = true;
      recommendedTlsSettings = true;
      sslCiphers = "AES256+EECDH:AES256+EDH:!aNULL";

      virtualHosts = {
        "nextcloud.t3mpt0n.com" = {
          forceSSL = true;
          enableACME = true;
        };
      };
    };
  };

  services.postgresql = {
    enable = true;
    ensureDatabases = [ "nextcloud" ];
    ensureUsers = [
      { name = "nextcloud"; ensurePermissions."DATABASE nextcloud" = "ALL PRIVILEGES";}
    ];
  };

  systemd.services."nextcloud-setup" = {
    requires = ["postgresql.service"];
    after = ["postgresql.service"];
  };
  
  security.acme = {
    acceptTerms = true;
    email = "cloud@t3mpt0n.com";
  };

  networking = {
    firewall = {
      enable = true;
      interfaces."enp4s0f3u2".allowedTCPPorts = [ 80 443 ];
      extraCommands = ''
        iptables -A nixos-fw -p tcp --source 192.168.1.167/24 --dport 80 -j nixos-fw-accept
        iptables -A nixos-fw -p tcp --source 192.168.1.167/24 --dport 443 -j nixos-fw-accept
      '';
    };
  };
}
