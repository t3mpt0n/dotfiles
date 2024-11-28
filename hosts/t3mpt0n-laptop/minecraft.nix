{
  config,
  lib,
  pkgs,
  ...
}: {
  services.minecraft-server = {
    enable = true;
    eula = true;
    jvmOpts = "-Xmx6G -Xms5G";
    serverProperties = {
      level-name = "t3mpt0n bash";
      difficulty="hard";
      motd="                    \u00A7b\u00A7lWELCOME!";
      declarative = true;
    };
  };
}
