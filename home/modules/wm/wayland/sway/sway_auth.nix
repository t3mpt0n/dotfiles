{
  pkgs,
  lib,
  config,
  ...
}:
{
  services.swayidle = {
    enable = true;
    events = [
      {
        event = "before-sleep";
        command = if config.programs.swaylock.enable then "${lib.getExe pkgs.swaylock}" else "";
      }
    ];

    timeouts = [
      {
        timeout = 300;
        command = "${pkgs.sway}/bin/swaymsg 'output * dpms off'";
        resumeCommand = "${pkgs.sway}/bin/swaymsg 'output * dpms on'";
      }
    ];
  };

  programs.swaylock = {
    enable = true;
    settings = {
      font-size = 32;
      show-failed-attempts = true;
      show-keyboard-layout = true;
      indicator-idle-visible = true;
    };
  };
}
