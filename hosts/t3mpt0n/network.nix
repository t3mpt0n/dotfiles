{
  lib,
  pkgs,
  config,
  ...
}: {
  networking = {
    firewall = {
      enable = true;
      allowedTCPPorts = [ 65017 65018 ];
    };

    nftables.enable = true;
  };

  services.pyload = {
    enable = true;
    user = config.users.users.jd.name;
    group = "pyload";
    port = 8967;
    credentialsFile = config.age.secrets.pyload.path;
    downloadDirectory = config.users.users.jd.home;
  };

  users.users.jd.extraGroups = lib.mkIf config.services.pyload.enable [ "pyload" ];
}
