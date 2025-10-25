{
  lib,
  config,
  pkgs,
  ...
}: {
    options.custom.browser.chromium.enable = lib.mkEnableOption "chromium";
}
