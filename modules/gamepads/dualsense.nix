{
  pkgs,
  lib,
  ...
}: {
  environment.systemPackages = with pkgs; [
    dualsensectl
    trigger-control
  ];

  services.udev.extraRules = ''
    ACTION=="add|change", KERNEL=="event[0-9]*", ATTRS{name}=="*Wireless Controller Touchpad", ENV{LIBINPUT_IGNORE_DEVICE}="1"
  '';
}
