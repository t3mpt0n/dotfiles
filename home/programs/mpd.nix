{
  pkgs,
  lib,
  config,
  ...
}: with lib; {
  services= {
    mpd = {
      enable = true;
      package = pkgs.mpd;
      musicDirectory = "/mnt/dhp/media/Audio/Music";

      network = {
        listenAddress = "0.0.0.0";
        port = 6601;
      };

      extraConfig = ''
      audio_output {
        type  "pipewire"
        name  "Pipewire Sound Server"
      }
    '';
    };

    spotifyd = {
      enable = true;
      package = (pkgs.spotifyd.override { withKeyring = true; withPulseAudio = true; });
      settings = {
        global = {
          username = "t3mpt0n";
          password_cmd = "cat /home/jd/.local/share/spotifyd/.pwd";
          backend = "pulseaudio";
          bitrate = 320;
        };
      };
    };
  };

  home.packages = with pkgs; [
    mpc-cli
    spotify
  ];
}
