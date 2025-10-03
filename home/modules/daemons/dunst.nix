{
  lib,
  config,
  pkgs,
  ...
}: {
  services.dunst = {
    enable = lib.mkDefaultOption true;
  };
}
