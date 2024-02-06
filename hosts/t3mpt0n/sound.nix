{
  config,
  lib,
  pkgs,
  ...
}: {
  environment.etc = let
    json = pkgs.formats.json {};
    in {
      "pipewire/pipewire.d/00-bose-sound.conf".source = json.generate "00-bose-sound.conf" {
        context.objects = [
          {
            factory = "spa-node-factory";
            args = {
              factory.name = "support.node.driver";
              node.name = "Dummy-Driver";
              priority.driver = 8000;
            };
          } # Dummy for JACK
          {
            factory = "adapter";
            args = {
              factory.name = "support.null-audio-sink";
              node.name = "bose-audio";
              node.description = "Bose Companion 5 Surround Sound Speakers";
              media.class = "Audio/Sink";
              object.linger = 1;
              audio.position = "FL,FR,RL,RR,FC";
            };
          }
        ];
      };
      "pipewire/pipewire.d/01-low-latency.conf".source = json.generate "01-low-latency.conf" {
        context.properties = {
          default.clock = {
            rate = 48000;
            quantum = 32;
            min-quantum = 32;
            max-quantum = 32;
          };
        };
      };
    };
  systemd.services.pipewire.postStart = ''
    pw-link "bose-audio:monitor_FL" "alsa_output.\'pci-0000:2f:00.4\'.pro-audio:playback_1"
    pw-link "bose-audio:monitor_FR" "alsa_output.\'pci-0000:2f:00.4\'.pro-audio:playback_2"
  '';
}
