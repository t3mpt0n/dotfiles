{
  pkgs,
  config,
  ...
}: {
  networking.firewall = {
    allowedUDPPorts = [51820];
  };
  networking.wg-quick.interfaces = {
    wg0 = {
      autostart = false;
      address = [
        "10.194.108.2/24"
        "fd11:5ee:bad:c0de::ac2:6c02/64"
      ];
      listenPort = 51820;
      privateKeyFile = config.age.secrets.desktop_wg_private_key.path;
      dns = [
        "9.9.9.9"
        "149.112.112.112"
      ];
      peers = [
        {
          publicKey = "knqysvaapHAb99Y2H4pf+ESfJYNDnv0ROyrhfMPweRw=";
          presharedKeyFile = config.age.secrets.wg_psk.path;
          allowedIPs = [ "0.0.0.0/0" "::0/0" ];
          endpoint = "94.130.181.35:51820";
          persistentKeepalive = 25;
        }
      ];
    };
  };
}
