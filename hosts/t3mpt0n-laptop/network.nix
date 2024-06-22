{
  pkgs,
  lib,
  config,
  ...
}: {
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
      allowedTCPPorts = [ 22 80 443 ];
    };
  };
}
