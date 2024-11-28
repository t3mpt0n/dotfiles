{
  config,
  lib,
  pkgs,
  ...
}: {
  services = {
    desktopManager = {
      plasma6 = {
        enableQt5Integration = true;
        enable = true;
      };
    };
  };
}
