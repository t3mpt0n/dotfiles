{
  lib,
  pkgs,
  config,
  ...
}: {
  environment.systemPackages = with pkgs; [
    gftp
  ];

  networking = {
    firewall = {
      enable = true;
      allowedTCPPorts = [ 65017 65018 ];
      trustedInterfaces = [ "virbr0" "enp42s0" ];
    };

    nftables.enable = true;
  };
}
