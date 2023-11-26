{
  pkgs,
  lib,
  config,
  ...
}: {
  boot.kernel.sysctl."net.ipv4.ip_forward" = 1;
  boot.kernel.sysctl."net.ipv6.conf.all.ip_forward" = 1;
  security.acme = {
    acceptTerms = true;
    defaults.email = "cloud@t3mpt0n.com";
    defaults.dnsProvider = "cloudfare";
  };

  services = {
    # postgresql.enable = true;
    mysql = {
      enable = true;
      package = pkgs.mariadb;
    };
    nginx = {
      enable = true;

      recommendedGzipSettings = true;
      recommendedOptimisation = true;
      recommendedProxySettings = true;
      recommendedTlsSettings = true;
      sslCiphers = "AES256+EECDH:AES256+EDH:!aNULL";
    };
  };

  networking = {
    hostName = "t3mpt0n-laptop";
    interfaces = {
      "enp4s0f3u2" = {
        useDHCP = false;
        ipv4.addresses = [
          {
            address = "192.168.1.200";
            prefixLength = 24;
          }
        ];
      };
    };

    nftables.enable = true;

    firewall = {
      enable = true;
      allowPing = true;
      trustedInterfaces = [ "lo" "enp4s0f3u2" ];
      allowedTCPPorts = [ 22 80 443 5432 ];
    };

    defaultGateway = "192.168.1.1";
    nameservers = [ "192.168.1.1" ];
  };
}
