{
  pkgs,
  ...
}:
{
  boot.initrd.kernelModules = [
    "usbhid"
    "joydev"
    "xpad"
  ];
  hardware.xpadneo.enable = true;
}
