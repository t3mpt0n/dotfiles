{ lib, ... }:
{
  services.mpd = {
    enable = true;
    extraConfig = ''
       audio_output {
      	  type "pipewire"
      		name "Pipewire Sound Server"
      	}
    '';
  };
}
