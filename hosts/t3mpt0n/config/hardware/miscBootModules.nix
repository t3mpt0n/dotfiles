{
  pkgs,
  ...
}: {
  boot.initrd.availableKernelModules = [
    "xhci_pci"
    "ahci"
    "usbhid"
    "sd_mod"
  ];

  hardware.enableRedistributableFirmware = true;
}
