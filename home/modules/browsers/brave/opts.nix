{
  lib,
  config,
  pkgs,
  ...
}: {
  options.custom.browser.chromium.brave.enable = lib.mkEnableOption "brave";
}
