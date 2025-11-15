{
  lib,
  pkgs,
  config,
  ...
}: {
  custom.browser = {
    chromium = {
      enable = false;
      brave.enable = false;
    };
  };

  programs.firefox.enable = true;
}
