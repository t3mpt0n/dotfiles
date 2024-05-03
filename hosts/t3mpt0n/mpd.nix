{
  pkgs,
  lib,
  config,
  ...
}: with lib; {
  services.mpd = {
    enable = true;
    startWhenNeeded = true;
    network = {
      listenAddress = "0.0.0.0";
      port = 6601;
    };

    musicDirectory = "/mnt/dhp/media/Audio/Music";
    user = "jd";
    group = "audio";

    extraConfig = ''
      audio_output {
        type  "pipewire"
        name  "Pipewire Sound Server"
      }
    '';
  };

  systemd.services.mpd.environment = {
    XDG_RUNTIME_DIR = "/run/user/${toString config.users.users.jd.uid}";
  };
}
