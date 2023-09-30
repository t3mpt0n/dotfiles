{
  pkgs,
  lib,
  config,
  ...
}: with lib; {
  services.mpd = {
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

  home.packages = with pkgs; mkIf (config.services.mpd.enable == true) [
    mpc-cli
  ];
}
