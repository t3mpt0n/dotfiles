{
  lib,
  config,
  pkgs,
  ...
}: {
  services = {
    displayManager = {
      sddm = {
        enable = lib.mkDefault false;
        wayland.enable = true;
      };
    };
    
    desktopManager = {
      plasma6 = {
        enable = lib.mkDefault false;
        enableQt5Integration = true;
      };
    };
  };
}
