{
  lib,
  config,
  pkgs,
  ...
}: {
  programs.chromium = {
    enable = lib.mkDefault config.custom.browser.chromium.enable;
  };
}
