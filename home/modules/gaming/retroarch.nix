{
  lib,
  config,
  pkgs,
  ...
}: {
  options.jc'.home.gaming.retroarch = {
    enable = lib.mkEnableOption "retroarch";
    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.retroarch-bare;
      description = "Retroarch package";
    };
    corelist = lib.mkOption {
      type = lib.types.listOf lib.types.package;
      default = [];
      description = "List of cores to use with retroarch";
    };
    enableJoypadAutoconfig = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Autoconfigure your controllers";
    };
    enableAssets = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Download Retroarch Assets";
    };
  };

  config = let    
  in lib.mkIf config.jc'.home.gaming.retroarch.enable {
    home.packages = lib.lists.flatten [
      config.jc'.home.gaming.retroarch.corelist
      config.jc'.home.gaming.retroarch.package
      (lib.mkIf config.jc'.home.gaming.retroarch.enableAssets pkgs.retroarch-assets)
      (lib.mkIf config.jc'.home.gaming.retroarch.enableJoypadAutoconfig pkgs.retroarch-joypad-autoconfig)
    ];
  };
}
