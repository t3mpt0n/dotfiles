{
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    inetutils
  ];

  networking = {
    hostName = "t3mpt0n";
    firewall = {
      enable = true;
      allowedTCPPorts = [
        53
        80
        49874
      ];
      allowedUDPPorts = [
        53
        80
        49874
      ];
      trustedInterfaces = [
        "virbr0"
        "enp42s0"
      ];
    };

    nftables.enable = true;
    nameservers = [
      "1.1.1.1"
      "194.242.2.2"
    ];
  };
}
