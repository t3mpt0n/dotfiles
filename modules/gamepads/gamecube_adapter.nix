{
  lib,
  pkgs,
  ...
}: {
  services.udev.packages = [ (pkgs.writeTextFile {
    name = "99-nintendo-controller.rules";
    text = ''
        SUBSYSTEM=="usb", ENV{DEVTYPE}=="usb_device", ATTRS{idVendor}=="057e", ATTRS{idProduct}=="0337", MODE="0666";
    '';
    destination = "/etc/udev/rules.d/51-gc-adapter.rules";
  })
  ];
}
