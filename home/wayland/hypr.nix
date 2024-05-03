{
  pkgs,
  lib,
  self,
  ...
}: {
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      monitor = [
        "HDMI-A-1,1680x1050@59.95,0x320,1"
        "DP-3,2560x1440@165,1680x0,1,vrr,1"
      ];
      bind = let
        inherit (self.outputs.packages.x86_64-linux) wofi-pass;
        mod = "SUPER";
        ss = "SUPER_SHIFT";
      in lib.mkOptionDefault [
        "${mod},e,exec,${pkgs.emacs29-pgtk}/bin/emacsclient -c -a 'emacs'" # EMACS
        "${mod},p,exec,${pkgs.wofi}/bin/wofi --show run" # WOFI
        "${ss},return,exec,${pkgs.emacs29-pgtk}/bin/emacsclient -c -a 'emacs' -e '(multi-vterm)'" # VTERM
        "${ss},p,exec,${wofi-pass}/bin/wofi-pass" # WOFI-PASS
        ",XF86AudioLowerVolume,exec,amixer sset Master 5%-" # Lower vol 5%
        ",XF86AudioRaiseVolume,exec,amixer sset Master 5%+" # Raise vol 5%
        ",XF86AudioMute,exec,amixer sset Master toggle" # Toggle mute
        "${ss},esc,exit"

        /* WORKSPACES */
        "${mod},1,workspace,1"
        "${mod},2,workspace,2"
        "${mod},3,workspace,3"
        "${mod},4,workspace,4"
        "${mod},5,workspace,5"
        "${mod},6,workspace,6"
        "${mod},7,workspace,7"
        "${mod},8,workspace,8"
        "${mod},9,workspace,9"
        "${mod},0,workspace,10"
        "${mod},tab,workspace,previous"
        "${ss},1,movetoworkspace,1"
        "${ss},2,movetoworkspace,2"
        "${ss},3,movetoworkspace,3"
        "${ss},4,movetoworkspace,4"
        "${ss},5,movetoworkspace,5"
        "${ss},6,movetoworkspace,6"
        "${ss},7,movetoworkspace,7"
        "${ss},8,movetoworkspace,8"
        "${ss},9,movetoworkspace,9"
        "${ss},0,movetoworkspace,10"
        "${ss},tab,movetoworkspace,previous"

        /* WINDOWS */
        "${mod},z,fullscreen,0"
        "${ss},z,fakefullscreen"
        "${mod},l,movefocus,r"
        "${mod},h,movefocus,l"
        "${mod},j,movefocus,d"
        "${mod},k,movefocus,u"
      ];
      env = [
        "XDG_CURRENT_DESKTOP,Hyprland"
        "XDG_SESSION_DESKTOP,Hyprland"
      ];
      exec-once = [
        "${pkgs.emacs29-pgtk}/bin/emacs --daemon"
        "${pkgs.corectrl}/bin/corectrl"
      ];
      exec = [
        "nix flake archive /etc/nixos"
      ];
    };
  };
}
