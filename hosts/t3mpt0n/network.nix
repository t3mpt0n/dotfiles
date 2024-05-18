{
  lib,
  pkgs,
  config,
  ...
}: {
  environment.systemPackages = with pkgs; [
    gftp
    inetutils
  ];

  networking = {
    hostName = "t3mpt0n";
    firewall = {
      enable = true;
      allowedTCPPorts = [ 65017 65018 ];
      trustedInterfaces = [ "virbr0" "enp42s0" ];
    };

    nftables.enable = true;
  };

  services = {
    mullvad-vpn = {
      enable = true;
    };
  };
}
