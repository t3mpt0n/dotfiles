{
  config,
  pkgs,
  ...
}: {
  boot.initrd.kernelModules = [ "amdgpu" ];
  boot.kernelParams = [
    "video=eDP-1:1920x1080@60"
    "consoleblank=0"
  ];
}
