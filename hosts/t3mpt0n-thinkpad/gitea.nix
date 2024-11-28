{
  config,
  lib,
  pkgs,
  ...
}: {
  services = {
    gitea = {
      enable = true;
      appName = "WELCOME!";
      settings = {
        server = {
          DOMAIN = "git.t3mpt0n.com";
          ROOT_URL = "https://git.t3mpt0n.com";
        };

        service.DISABLE_REGISTRATION = true;
      };

      

      database = {
        type = "postgres";
        passwordFile = config.age.secrets.gitea.path;
      };
    };

    postgresql = {
      ensureDatabases = [ "gitea" ];
      ensureUsers = [
        {
          name = "gitea";
          ensureDBOwnership = true;
        }
      ];
    };

    nginx.virtualHosts."git.t3mpt0n.com" = {
      enableACME = true;
      forceSSL = true;
      locations."/" = {
        proxyPass = "http://localhost:3000";
      };
    };
  };

  networking.firewall.allowedTCPPorts = [ config.services.gitea.settings.server.HTTP_PORT config.services.gitea.database.port ];
}
