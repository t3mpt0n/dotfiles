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
    enableIPv6 = false;
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
      allowedTCPPorts = [ 22 80 443 ];
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
    preliminarySelfsigned = true;
    defaults.email = "t3mpt0n@tutanota.com";
    defaults.dnsProvider = "cloudflare";
    certs."t3mpt0n.com" = {
      dnsResolver = "1.1.1.1:53";
      dnsPropagationCheck = true;
      domain = "t3mpt0n.com";
      credentialsFile = config.age.secrets.cloudflare_creds.path;
      extraDomainNames = [ "*.t3mpt0n.com" ];
      reloadServices = [ "nginx" ];
    };
  };
}
