{
  config,
  lib,
  pkgs,
  ...
}: {
  programs = {
    adb.enable = true;
    droidcam.enable = true;
  };
  environment.systemPackages = with pkgs; [
    android-tools
    android-udev-rules
    android-file-transfer
    scrcpy # Control phone from PC
  ];

  services.udev.extraRules = ''
    SUBSYSTEM=="usb", ATTR{idVendor}=="18d1", ATTR{idProduct}=="4ee7", MODE="0666", GROUP="plugdev"
  '';

  users.users.jd.extraGroups = [ "plugdev" "adbusers" ];
}
