{
  lib,
  config,
  pkgs,
  ...
}: {
  options.jc'.srv = {
    aria2 = {
      enable = lib.mkEnableOption "aria2";
      webUI = lib.mkOption {
        type = lib.types.bool;
        default = config.jc'.srv.caddy.enable;
        description = "Enable Aria2C WebUI via AriaNG";
      };
    };

    caddy = {
      enable = lib.mkEnableOption "caddy";
    };
  };
}
