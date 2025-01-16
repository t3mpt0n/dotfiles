{
  pkgs,
  config,
  ...
}: {
  boot.kernelParams = [
    "video=HDMI-A-1:1680x1050@60"
    "video=DP-3:2560x1440@165"
    "consoleblank=0"
  ];

  chaotic.hdr = {
    enable = false;
  };

  hardware = {
    graphics = {
      enable32Bit = true;
      extraPackages = with pkgs; [
        libva
        libva-utils
        libplacebo
        shaderc
        vulkan-headers
        vulkan-loader
        glxinfo
        vulkan-tools
      ];
    };

    amdgpu = {
      initrd.enable = true;
      opencl.enable = true;
      amdvlk = {
        enable = false;
        support32Bit.enable = false;
      };
    };
  };

  programs.corectrl = {
    enable = true;
    gpuOverclock = {
      enable = true;
      ppfeaturemask = "0xffffffff";
    };
  };

  environment.sessionVariables = {
    AMD_VULKAN_ICD = "RADV";
  };
}
