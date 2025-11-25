{
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    inetutils
    dnsmasq
    ebtables
  ];

  networking = {
    defaultGateway = "192.168.1.1";
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
        "enp42s0"
      ];
      interfaces = {
        "virbr*" = {
          allowedTCPPorts = [ 53 ];
          allowedUDPPorts = [ 53 67 547 ];
        };
      };
    };
    nameservers = [
      "1.1.1.1"
      "194.242.2.2"
    ];
  };
}
