{
  pkgs,
  config,
  ...
}: {
  boot.initrd.kernelModules = [ "amdgpu" ];
  boot.kernelParams = [
    "video=HDMI-A-1:1680x1050@60"
    "video=DP-3:2560x1440@165"
    "consoleblank=0"
    "amdgpu.ppfeaturemask=0xffffffff"
  ];

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
    extraPackages = with pkgs; [
      rocm-opencl-icd
      rocm-opencl-runtime
      libva
      libva-utils
      amdvlk
      libplacebo
      shaderc
      vulkan-headers
      vulkan-loader
      glxinfo
      vulkan-tools
    ];
    extraPackages32 = with pkgs.driversi686Linux; [
      amdvlk
      glxinfo
    ];
  };

  environment = {
    systemPackages = with pkgs; [
      /* GET CORECTRL TO WORK */
      botan2
      hwdata
      corectrl
    ] ++ config.hardware.opengl.extraPackages ++ config.hardware.opengl.extraPackages32;
    variables = {
      AMD_VULKAN_ICD = "RADV";
      RADV_PERFTEST = "aco";
    };
  };
}
