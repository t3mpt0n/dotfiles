{
  pkgs,
  ...
}:
{
  boot.kernelParams = [
    "video=eDP-1:1920x1080@60"
    "consoleblank=0"
  ];

  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
        libva
        libva-utils
        libplacebo
        shaderc
        vulkan-headers
        vulkan-loader
        vulkan-tools
      ];
    };

    amdgpu = {
      initrd.enable = true;
      opencl.enable = true;
    };
  };

  environment.sessionVariables = {
    AMD_VULKAN_ICD = "RADV";
  };
}
