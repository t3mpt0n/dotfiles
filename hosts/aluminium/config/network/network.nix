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
        "enp4s0f4u2"
        "wlp2s0"
      ];
    };

    nftables.enable = true;
    nameservers = [
      "1.1.1.1"
      "194.242.2.2"
    ];
  };
}
