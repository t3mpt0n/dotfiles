{
  lib,
  config,
  pkgs,
  ...
}: {
  home.packages = [
    (lib.mkIf config.custom.browser.chromium.brave.enable pkgs.brave)
  ];
}
