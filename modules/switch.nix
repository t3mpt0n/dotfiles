{
  pkgs,
  lib,
  ...
}: {
  services.udev.extraRules = ''
 SUBSYSTEM=="usb", ATTRS{idVendor}=="057e", ATTRS{idProduct}=="3000", MODE="0666"
  '';
}