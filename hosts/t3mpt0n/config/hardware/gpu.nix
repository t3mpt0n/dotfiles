{
  pkgs,
  ...
}:
{
  boot = {
    kernelParams = [
      "video=DP-3:2560x1440@165"
      "consoleblank=0"
    ];
    kernelModules = [ "kvm-amd" ];
  };
  
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
        mesa-demos
        vulkan-tools
      ];
    };

    amdgpu = {
      initrd.enable = true;
      opencl.enable = true;
      overdrive = {
        enable = true;
        ppfeaturemask = "0xffffffff";
      };
    };
  };

  services.lact = {
    enable = true;
  };
  
  environment.sessionVariables = {
    AMD_VULKAN_ICD = "RADV";
  };
}
