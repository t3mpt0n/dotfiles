{
  config,
  lib,
  pkgs,
  ...
}: {
  networking = let
    my_vpn = {
      port = 51820;
      wgip = "10.255.65.3";
      endpoint = "107.175.28.215:51820";
    };
    in {
    firewall.allowedUDPPorts = [my_vpn.port];
    wg-quick.interfaces = {
      wg0 = {
        address = [ my_vpn.wgip ];
        autostart = false;
        listenPort = my_vpn.port;
        dns = [
          "9.9.9.9"
          "149.112.112.112"
        ];
        peers = [
          {
            allowedIPs = [ "0.0.0.0/0" ];
            presharedKeyFile = config.age.secrets.tp-psk.path;
            publicKey = "rxRtNTu2tV0VbG+qVx35phd5kXU3iSSHyFHLwbFfRRk=";
            endpoint = my_vpn.endpoint;
          }
        ];
        privateKeyFile = config.age.secrets.tp-pk.path;
      };
    };
  };
}
