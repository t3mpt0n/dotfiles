{
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    alsa-lib
    alsa-utils
    pulsemixer
    pulseaudio
    ffmpeg
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
}
