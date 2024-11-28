{
  pkgs,
  inputs,
  ...
}: {
  programs.waybar = {
    enable = true;
    package = pkgs.waybar;

    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        output = [
          "DP-3"
          "HDMI-A-1"
        ];
        modules-left = [ "sway/workspaces" "custom/padding3" "disk" "custom/padding3" "disk#hdd" "custom/padding6" "custom/kernel_icon" "custom/kernel" "custom/padding6" "sway/mode" ];
        modules-center = [ "clock" ];
        modules-right = [ "network" "custom/padding5" "custom/cpu_icon" "cpu" "custom/cpu_temp" "custom/padding2" "memory" "custom/padding1" "pulseaudio" "custom/padding0" "tray" ];

        /* MODULE CONFIG */
        "sway/workspaces" = {
          numeric-first = true;
          format = "{icon}";
          format-icons = {
            "1" = "";
            "2" = "󰓇";
            "3" = "󰈹";
            "4" = "󰙯";
            "5" = "󰊴";
            "6" = "";
          };
        };
        "clock" = {
          interval = 1;
          format = "({:%a) %H:%M:%S}";
          format-alt = "({:%a) %y-%m-%d}";
        };
        "disk" = {
          interval = 15;
          states = {
            "low" = 0;
            "moderate" = 25;
            "warning" = 60;
            "high" = 80;
          };
          format = "/: {used}/{total}";
          path = "/";
        };
        "disk#hdd" = {
          interval = 15;
          format = " {used}/{total}";
          path = "/mnt/dhp";
        };
        "pulseaudio" = {
          format = "{icon} {volume}%";
          states = {
            "off" = 0;
            "very_low" = 1;
            "low" = 15;
            "medium" = 60;
            "high" = 85;
            "max" = 99;
          };
          format-muted = "󰝟";
          format-icons = {
            "headphones" = "";
            "headset" = "󰋎";
            "default" = [ "󰕿" "󰖀" "󰕾"];
          };
        };
        "memory" = {
          interval = 1;
          states = {
            "low" = 0;
            "moderate" = 25;
            "warning" = 60;
            "high" = 80;
          };
          format = "{icon} {percentage}%";
          format-alt = "{icon} {used}GB";
          format-icons = {
            "low" = "󰍛󰡳";
            "moderate" = "󰍛󰡵";
            "warning" = "󰍛󰊚";
            "high" = "󰍛󰡴";
            "default" = "󰍛";
          };
        };
        "cpu" = {
          interval = 1;
          states = {
            "low" = 0;
            "moderate" = 25;
            "warning" = 60;
            "high" = 80;
          };
          format = "{icon} {usage}%";
          format-icons = {
            "low" = "󰡳";
            "moderate" = "󰡵";
            "warning" = "󰊚";
            "high" = "󰡴";
          };
        };
        "network" = {
          interval = 1;
          format-ethernet = "󰈀  {bandwidthDownBits}  {bandwidthUpBits}";
          tooltip-format-ethernet = "󰈀 {ipaddr}/{cidr}";
        };
#         "mpd" = {
#           format = "󰎈 {stateIcon}{consumeIcon}{randomIcon}{repeatIcon}{singleIcon}// {artist}// {title}";
#           format-disconnected = "";
#           format-stopped = "󰎈 󰓛";
#           server = "0.0.0.0";
#           port = 6601;
#           interval = 2;
#           state-icons = {
#             paused = "󰏤";
#             playing = "󰐊";
#           };
#           repeat-icons = {
#             off = "";
#             on = " ";
#           };
#           random-icons = {
#             off = "";
#             on = "󰒟 ";
#           };
#           single-icons = {
#             off = "";
#             on = "1";
#           };
#           consume-icons = {
#             off = "";
#             on = " ";
#           };
#         };

        /* CUSTOM MODULES */
        "custom/cpu_temp" = {
          exec = "sensors | grep -i tccd | awk -F: '{ print $2 }' | sed 's/ //g; s/+//g'";
          format = " {}";
          interval = 1;
          tooltip = false;
        };
        "custom/cpu_icon" = {
          exec = "/etc/nixos/home/programs/waybar-scripts/cpubits.sh";
          tooltip = false;
        };
        "custom/kernel_icon" = {
          format = " ";
          tooltip = false;
        };
        "custom/kernel" = {
          exec = "uname -r";
          tooltip = false;
        };
        "custom/padding0" = {
          format = " ";
          tooltip = false;
        };
        "custom/padding1" = {
          format = " ";
          tooltip = false;
        };
        "custom/padding2" = {
          format = " ";
          tooltip = false;
        };
        "custom/padding3" = {
          format = " ";
          tooltip = false;
        };
        "custom/padding4" = {
          format = " ";
          tooltip = false;
        };
        "custom/padding5" = {
          format = " ";
          tooltip = false;
        };
        "custom/padding6" = {
          format = " ";
          tooltip = false;
        };
        "custom/padding7" = {
          format = " ";
          tooltip = false;
        };
      };
    };

    style = ''
      * {
        border: none;
        border-radius: 0;
        font-family: "Fira Code", Roboto, Helvetica, Arial, sans-serif;
        font-size: 20px;
        min-height: 0;
      }

      window.HDMI-A-1 * {
          font-size: 14px;
      }

      window#waybar {
        background-color: rgba(43, 48, 59, 0.6);
        color: #ffffff;
        border-radius: 0;
      }

      window#waybar.hidden {
        opacity: 0.2;
      }

      #workspaces button {
        color: #ffffff;
        padding-left: 7px;
        padding-right: 9px;
      }

      #workspaces button.visible {
        background-color: rgba(43, 48, 59, 0.5);
        border-bottom: 2px solid #ffffff;
      }

      #clock {
        border-bottom: 2px solid #ffffff;
      }

      /*
      .modules-right {
        padding-left: 7px;
        padding-right: 9px;
      } */

      #pulseaudio {
          padding: 0 0 0 0;
          border-bottom: 2px solid #fff;
      }

      #tray {
          padding-right: 7px;
      }

      #memory {
          border-bottom: 2px solid #fff;
      }

      #cpu {
          padding: 0 0 0 0;
          border-bottom: 2px solid #fff;
      }

      #disk {
        border-bottom: 2px solid #fff;
      }

      #custom-cpu_icon {
          font-size: 24px;
          padding-bottom: 2px;
          padding-right: 2px;
          border-bottom: 2px solid #fff;
      }

      #mpd {
        border-bottom: 2px solid #fff;
      }

      #network {
        border-bottom: 2px solid #fff;
      }
      #custom-kernel_icon {
        border-bottom: 2px solid #fff;
      }
      #custom-kernel {
        border-bottom: 2px solid #fff;
      }

      #custom-cpu_temp {
          border-bottom: 2px solid #fff;
      }
      #custom-padding0 {
          padding-left: 7px;
      }
      #custom-padding1 {
          padding-left: 7px;
          padding-right: 8px;
      }
      #custom-padding2 {
          padding-left: 7px;
          padding-right: 8px;
      }
      #custom-padding3 {
          padding-left: 8px;
          padding-right: 7px;
      }
      #custom-padding5 {
          padding-left: 8px;
          padding-right: 7px;
      }
      #custom-padding6 {
          padding-left: 8px;
          padding-right: 7px;
      }
    '';
  };
}
