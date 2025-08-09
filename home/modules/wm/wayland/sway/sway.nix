{
  pkgs,
  lib,
  config,
  ...
}: {
  wayland.windowManager.sway = {
    enable = true;
    xwayland = true;
    config = rec {
      modifier = "Mod4";
      bars = [
        {command = "${lib.getExe pkgs.waybar}";}
      ];
      input = {
        "type:keyboard" = {
          xkb_layout = "us,us(intl)";
        };
      };
      keybindings = let
        M = "${modifier}";
        wn = n: "workspace number " + (toString n);
        mwn = n: "move container to workspace number " + (toString n);
      in {
        "${M}+Shift+c" = "reload";
        "${M}+Ctrl+Q" = "exec swaylock";
        "${M}+e" = "exec ${lib.getExe' pkgs.emacs30-pgtk "emacsclient"} -c -a 'emacs'";

        # Window keys
        "${M}+h" = "focus left";
        "${M}+j" = "focus down";
        "${M}+k" = "focus up";
        "${M}+l" = "focus right";
        "${M}+Shift+Left" = "move left";
        "${M}+Shift+Down" = "move down";
        "${M}+Shift+Up" = "move up";
        "${M}+Shift+Right" = "move right";
        "${M}+Shift+H" = "move left";
        "${M}+Shift+J" = "move down";
        "${M}+Shift+K" = "move up";
        "${M}+Shift+L" = "move right";
        "${M}+1" = wn 1;
        "${M}+2" = wn 2;
        "${M}+3" = wn 3;
        "${M}+4" = wn 4;
        "${M}+5" = wn 5;
        "${M}+6" = wn 6;
        "${M}+7" = wn 7;
        "${M}+8" = wn 8;
        "${M}+9" = wn 9;
        "${M}+0" = wn 10;
        "${M}+Shift+1" = mwn 1;
        "${M}+Shift+2" = mwn 2;
        "${M}+Shift+3" = mwn 3;
        "${M}+Shift+4" = mwn 4;
        "${M}+Shift+5" = mwn 5;
        "${M}+Shift+6" = mwn 6;
        "${M}+Shift+7" = mwn 7;
        "${M}+Shift+8" = mwn 8;
        "${M}+Shift+9" = mwn 9;
        "${M}+Shift+0" = mwn 10;
        "${M}+Shift+q" = "kill";
        "${M}+f" = "fullscreen";
        "${M}+Shift+f" = "inhibit_fullscreen toggle";

        # Layout keys
        "${M}+Alt+w" = "layout tabbed";
        "${M}+Alt+e" = "layout toggle split";
        "${M}+Alt+v" = "splitv";
        "${M}+Alt+h" = "splith";

        # Switch Keyboard layout
        "${M}+Alt+tab" = "input type:keyboard xkb_switch_layout next";

        # Volume keys
        "XF86AudioLowerVolume" = "exec ${lib.getExe' pkgs.alsa-utils "amixer"} sset Master 5%-";
        "XF86AudioRaiseVolume" = "exec ${lib.getExe' pkgs.alsa-utils "amixer"} sset Master 5%+";
        "XF86AudioMute" = "exec ${lib.getExe' pkgs.alsa-utils "amixer"} sset Master toggle";

        # Brightness keys
        "Shift+XF86AudioRaiseVolume" = "exec ${lib.getExe pkgs.brightnessctl} set 5%+";
        "Shift+XF86AudioLowerVolume" = "exec ${lib.getExe pkgs.brightnessctl} set 5%-";
      };
      colors = {
        unfocused = {
          background = "#808080"; # grey
          border = "#ABB2B9"; # light grey
          text = "#FFFFFF"; # white
          indicator = "#409876";
          childBorder = "#ABB2B9";
        };

        focused = {
          background = "#000000"; # black
          border = "#FF8C00"; # Dark Orange
          text = "#FFFFFF";
          indicator = "#409876";
          childBorder = "#FF8C00";
        };

        urgent = {
          background = "#FF0000"; # Red
          border = "#FF0000";
          text = "#FFFFFF";
          indicator = "#859457";
          childBorder = "#FF0000";
        };
      };

      gaps = {
        inner = 5;
        outer = 3;
      };

      fonts = {
        names = ["MonaspiceKr Nerd Font"];
        style = "Bold";
        size = 16.0;
      };

      window.commands = [
        {
          command = "inhibit_idle fullscreen";
          criteria = {
            class = ".*";
            app_id = ".*";
          };
        }
      ];
    };

    systemd = {
      enable = true;
      extraCommands = [
        "systemctl --user reset-failed"
        "systemctl --user start sway-session.target"
        "swaymsg -mt subscribe '[]' || true"
        "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1"
        "systemctl --user stop sway-session.target"
      ];
    };
    extraConfig = ''
          default_border pixel 2
      default_floating_border pixel 2
          smart_borders on
          titlebar_padding 1
          titlebar_border_thickness 0
    '';
  };
}
