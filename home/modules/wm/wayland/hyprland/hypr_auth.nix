{ pkgs, lib, ... }:
{
  programs.hyprlock = {
    enable = true;
  };

  services.hypridle = {
    enable = true;
    settings = {
      general = {
        lock_cmd = "${lib.getExe pkgs.hyprlock}";
        before_sleep_cmd = "loginctl lock-session";
        after_sleep_cmd = "${lib.getExe' pkgs.hyprland "hyprctl"} dispatch dpms on";
      };

      listeners = [
        {
          timeout = 300;
          on-timeout = "${lib.getExe' pkgs.hyprland "hyprctl"} dispatch dpms off";
          on-resume = "${lib.getExe' pkgs.hyprland "hyprctl"} dispatch dpms on";
        }
      ];
    };
  };
}
