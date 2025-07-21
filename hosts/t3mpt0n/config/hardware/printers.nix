{
  pkgs,
  lib,
  self,
  ...
}: {
  services.printing.drivers = with pkgs; [
    brgenml1cupswrapper
    brgenml1lpr
    brscan4
    ghostscript
    gutenprint
    gutenprintBin
  ];
  hardware.sane = {
    extraBackends = with pkgs; [
      brscan4
      sane-airscan
    ];

    brscan4 = {
      enable = true;
      netDevices.mfcj1205w = {
        ip = "192.168.1.165";
        model = "MFC-J1205W";
      };
    };
  };
  hardware.printers = {
    ensurePrinters =  [
      {
        name = "Brother_MFCJ1205W";
        location = "Bedroom";
        deviceUri = "ipp://192.168.1.165/ipp/print";
        model = "everywhere";
      }
    ];
    ensureDefaultPrinter = "Brother_MFCJ1205W";
  };
  services.printing.logLevel = "debug";
  environment.systemPackages = with pkgs; [
    simple-scan
    xsane
  ];
}
