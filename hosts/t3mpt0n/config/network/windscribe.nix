{
  pkgs,
  config,
  ...
}: {
  networking.firewall.allowedUDPPorts = [ 65142 ];
  
  age.secrets = {
    windscribe_private_key = {
      file = ../../../../age/wpk.age;
    };
    windscribe_preshared_key = {
      file = ../../../../age/wpsk.age;
    };
  };
  
  networking.wg-quick.interfaces = {
    wg0 = {
      autostart = false;
      address = [
        "100.93.69.158/32"
      ];
      dns = [ "10.255.255.2" ];
      privateKeyFile = config.age.secrets.windscribe_private_key.path;
      peers = [
        {
          publicKey = "nfFRpFZ0ZXWVoz8C4gP5ti7V1snFT1gV8EcIxTWJtB4=";
          presharedKeyFile = config.age.secrets.windscribe_preshared_key.path;
          allowedIPs = [
            "0.0.0.0/0"
            "::/0"
          ];
          endpoint = "yul-359-wg.whiskergalaxy.com:65142";
          persistentKeepalive = 25;
        }
      ];
    };
  };
}
