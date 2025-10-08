{
  lib,
  pkgs,
  config,
  ...
}: {
  programs.waybar.settings.mainBar = {
    modules-left = [ "hyprland/workspaces" "disk" ];
  };
}
