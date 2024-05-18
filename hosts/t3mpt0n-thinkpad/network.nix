{
  pkgs,
  lib,
  config,
  ...
}: {
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
      allowedTCPPorts = [ 22 ];
    };
  };
}
