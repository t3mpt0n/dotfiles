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

  programs.firefox.enable = true;
}
