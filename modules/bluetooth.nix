{
  lib,
  pkgs,
  ...
}: {
  hardware.bluetooth.enable = true;
  hardware.bluetooth.package = pkgs.bluez;
  services.blueman.enable = true;
  environment.systemPackages = with pkgs; [
    bluez-tools
  ];
}
