{
  lib,
  config,
  pkgs,
  ...
}:
{
  programs.waybar = {
    enable = true;
    package = pkgs.waybar;

    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        modules-left = lib.mkDefault [
          "sway/workspaces"
          "disk"
        ];
        modules-center = lib.mkDefault [ "clock" ];
        modules-right = lib.mkDefault [
          "network"
          "cpu"
          "memory"
          "pulseaudio"
          "tray"
        ];

        # MODULE CONFIG
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
            "default" = [
              "󰕿"
              "󰖀"
              "󰕾"
            ];
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
          format = "󰻠{icon} {usage}%";
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
          format-wifi = "󰖩  {bandwidthDownBits}  {bandwidthUpBits}";
          tooltip-format-ethernet = "󰈀 {ipaddr}/{cidr}";
          tooltip-format-wifi = "󰖩 {ipaddr}/{cidr}";
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

        # CUSTOM MODULES
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

    style = lib.mkDefault (builtins.readFile ./waybar.css);
  };
}
