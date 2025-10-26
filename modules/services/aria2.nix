{
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [ ./opts.nix ];

  sops.secrets.aria2-token = {
    sopsFile = ../../sops/aria2.yaml;
    format = "yaml";
  };
  
  services = {
    aria2 = lib.mkDefault {
      enable = config.jc'.srv.aria2.enable;
      openPorts = config.networking.firewall.enable;
      rpcSecretFile = config.sops.secrets.aria2-token.path;
    };

    caddy = lib.mkIf config.jc'.srv.aria2.webUI {
      virtualHosts."http://localhost:${toString (config.services.aria2.settings.rpc-listen-port - 1)}" = {
        extraConfig = ''
          file_server {
            root ${pkgs.ariang}/share/ariang
          }
          reverse_proxy /jsonrpc localhost:${toString config.services.aria2.settings.rpc-listen-port}
        '';
      };
    };
  };
}
