# Config reaped from here: https://voidcruiser.nl/rambles/i2p-on-nixos/
{ ... }: {
  containers.i2pd-container = {
    autoStart = true;
    config = { ... }: {
      system.stateVersion = "24.11";
      networking.firewall.allowedTCPPorts = [
        7656
        7655
        7070
        4447
        4444
      ];

      services.i2pd = {
        enable = true;
        address = "127.0.0.1";
        proto = {
          http.enable = true;
          socksProxy.enable = true;
          httpProxy.enable = true;
          sam.enable = true;
          i2cp.enable = true;
        };
      };
    };
  };
}
