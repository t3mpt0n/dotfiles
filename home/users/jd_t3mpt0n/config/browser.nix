{
  lib,
  pkgs,
  config,
  ...
}: {
  custom.browser = {
    chromium = {
      enable = true;
      brave.enable = true;
    };
  };
}
