{
  lib,
  config,
  pkgs,
  ...
}: {
  custom.browser = {
    chromium = {
      enable = true;
      brave.enable = true;
    };
  };
}
