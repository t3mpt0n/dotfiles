{
  pkgs,
  config,
  ...
}: {
  network.wireguard = {
    enable = true;
    interfaces = {

      wg0 = {
        ips = [ "10.0.0.1/24" ];
        listenPort = 51820;
        privateKeyFile = config.age.secrets.wg_pk.path;

        peers = [
          {
            name = "t3mpt0n_NixOS_Desktop";
            publicKey = "gdfZNuI/iSHSkBTuhyfe2Et8aeVCPKIh9vHl9bydu3Q=";
            presharedKeyFile = config.age.secrets.hetzner_wg_psk.path;
            endpoint = "178.156.198.20:51820";

            persistentKeepalive = 25;
          }
        ];
      };
    };
  };
}
