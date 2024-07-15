{
  config,
  lib,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [ monero-cli monero-gui p2pool ];
  services.monero = {
    enable = false;
    mining.enable = false;
    mining.address = "4AvNsqcfrPaiSVLgjF4VW4j6xUWAWZMwz5HBxwmmugtd9MF5tGfKn59iZ6GkpwcLNDBGPhtrUbSU1i7xfSrj1zBZDVgvrj6";
  };

  services.xmrig = {
    enable = false;
    settings = {
      cpu = true;
      opencl = true;
      autosave = true;
      pools = [
        {
          url = "https://p2pool.io:3333";
          user = "4AvNsqcfrPaiSVLgjF4VW4j6xUWAWZMwz5HBxwmmugtd9MF5tGfKn59iZ6GkpwcLNDBGPhtrUbSU1i7xfSrj1zBZDVgvrj6";
          tls = true;
          keepalive = true;
        }
      ];
    };
  };
}
