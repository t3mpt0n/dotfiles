{
  lib,
  pkgs,
  config,
  ...
}: {
  options = {
    t'.home.crypto.enable = lib.mkEnableOption "crypto";
  };

  config = lib.mkIf config.t'.home.crypto.enable {
    services.flatpak = {
      packages = [
        "com.cakewallet.cake_wallet"
      ];
    };

    home.packages = [
      pkgs.bisq2
    ];
  };
}
