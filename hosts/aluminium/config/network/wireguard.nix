{ config, ... }:
{
  networking =
    let
      my_vpn = rec {
        port = 51820;
        wgip = "10.255.65.5";
        endpoint = "107.175.28.215:51820";
      };
    in
    {
      firewall.allowedUDPPorts = [ my_vpn.port ];
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
              allowedIPs = [
                "0.0.0.0/0"
                "::0/0"
              ];
              presharedKeyFile = config.age.secrets.alvpn-psk.path;
              publicKey = "rxRtNTu2tV0VbG+qVx35phd5kXU3iSSHyFHLwbFfRRk=";
              inherit (my_vpn) endpoint;
            }
          ];
          privateKeyFile = config.age.secrets.alvpn-pk.path;
        };
      };
    };
}
