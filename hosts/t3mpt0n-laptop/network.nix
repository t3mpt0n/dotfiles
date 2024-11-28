{
  pkgs,
  lib,
  config,
  ...
}: {
  networking = {
    hostName = "t3mpt0n-laptop";
    nameservers = [ "1.1.1.1" "194.242.2.2" ];
    nftables.enable = true;
    firewall = {
      enable = true;
      allowPing = true;
      trustedInterfaces = [ "lo" "enp4s0f3u2" ];
      allowedTCPPorts = [ 22 25565 ];
    };
  };
}
