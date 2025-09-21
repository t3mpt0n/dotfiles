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
    hostId = "dd6e4664";
    firewall = {
      enable = true;
      allowedTCPPorts = [
        53
        80
        2234
      ];
      allowedUDPPorts = [
        53
        80
        2234
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
