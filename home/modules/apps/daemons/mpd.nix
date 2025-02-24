{
  lib,
  config,
  ...
}: {
  services.mpd = {
    enable = true;
    extraConfig = ''
      audio_output {
        type "pipewire"
      	name "Pipewire Sound Server"
      }
    '';
  };

  home.sessionVariables = {
    MPD_SERVER_NAME = "${config.services.mpd.network.listenAddress}";
    MPD_SERVER_PORT = "${toString config.services.mpd.network.port}";
    MPD_MUSIC_DIR = "${config.services.mpd.musicDirectory}";
  };
}
