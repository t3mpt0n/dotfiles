{
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    alsa-lib
    alsa-utils
    alsa-oss
    pulsemixer
    pulseaudio
    ffmpeg
    openal
  ];

  services.pipewire = {
    enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
    pulse.enable = true;
    jack.enable = true;
  };

  programs.noisetorch.enable = true;
}
