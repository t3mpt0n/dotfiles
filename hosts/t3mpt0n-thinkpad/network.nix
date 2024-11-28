{
  pkgs,
  lib,
  config,
  ...
}: {
  boot.kernel.sysctl = {
    "net.ipv4.ip_forward" = 1;
  };
  networking = {
    hostName = "t3mpt0n-thinkpad";
    interfaces = {
      "enp3s0" = {
        useDHCP = false;
        ipv4.addresses = [
          {
            address = "192.168.1.190";
            prefixLength = 24;
          }
        ];
      };
    };
    nftables.enable = true;
    firewall = {
      enable = true;
      allowPing = true;
      trustedInterfaces = [ "lo" "enp3s0" ];
      allowedTCPPorts = [ 22 53 80 443 ];
    };

    defaultGateway = "192.168.1.1";
    nameservers = [ "192.168.1.1" "1.1.1.1" "8.8.8.8" ];
  };
  services = {
    nginx = {
      enable = true;
      recommendedGzipSettings = true;
      recommendedOptimisation = true;
      recommendedProxySettings = true;
      recommendedTlsSettings = true;
      sslCiphers = "AES256+EECDH:AES256+EDH:!aNULL";
    };
  };

  security.acme = {
    acceptTerms = true;
    defaults.email = "cloud@t3mpt0n.com";
  };
}
