{
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [ ./opts.nix ];

  services.caddy = lib.mkIf config.jc'.srv.caddy.enable {
    enable = true;
  };
}
