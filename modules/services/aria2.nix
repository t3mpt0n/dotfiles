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
  };

  environment.systemPackages = [ (lib.mkIf config.jc'.srv.aria2.enable pkgs.ariang) ];
}
