{
  lib,
  osConfig,
  pkgs,
  ...
}: {
  services.mpd = {
    enable = lib.mkDefault false;
    extraConfig = lib.mkIf osConfig.services.pipewire.enable ''
      audio_output {
        type "pipewire"
        name "My PipeWire Output"
      }
    '';
  };
}
