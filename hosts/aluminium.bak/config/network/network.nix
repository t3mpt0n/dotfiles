{
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    inetutils
  ];

  networking = {
    hostName = "aluminium";
    firewall = {
      enable = true;
      trustedInterfaces = [
        "virbr0"
        "wlp2s0"
        "enp42s0f4u2c2"
      ];
    };

    nftables.enable = true;
    nameservers = [
      "1.1.1.1"
      "194.242.2.2"
    ];
  };
}
