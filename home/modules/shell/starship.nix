{ lib, ... }:
{
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    enableBashIntegration = true;
    enableFishIntegration = true;
    settings = {
      palettes = {
        gruvbox_dark = {
          color_fg0 = "#fbf1c7";
          color_bg1 = "#3c3836";
          color_bg3 = "#665c54";
          color_blue = "#458588";
          color_aqua = "#689d6a";
          color_green = "#98971a";
          color_orange = "#d65d0e";
          color_purple = "#b16286";
          color_red = "#cc241d";
          color_yellow = "#d79921";
        };
      };
      palette = "gruvbox_dark";
      os = {
        disabled = false;
        style = "bg:color_orange fg:color_fg0";
        symbols = {
          Macos = "󰀵";
          NixOS = "";
          Windows = "";
        };
      };
      username = {
        show_always = true;
        style_user = "bg:color_orange fg:color_fg0";
        style_root = "bg:color_orange fg:color_fg0";
        format = "[ $user ]($style)";
      };
      directory = {
        style = "fg:color_fg0 bg:color_yellow";
        format = "[ $path ]($style)";
        truncation_length = 3;
        truncation_symbol = ".../";
      };
      time = {
        disabled = false;
        time_format = "%R";
        style = "bg:color_bg1";
        format = "[[  $time ](fg:color_fg0 bg:color_bg1)]($style)";
      };
      git_branch = {
        symbol = "";
        style = "bg:color_bg3";
        format = "[[ $symbol $branch ](fg:color_fg0 bg:color_bg3)]($style)";
      };
      git_status = {
        style = "bg:color_bg3";
        format = "[[($all_status$ahead_behind )](fg:color_fg0 bg:color_bg3)]($style)";
      };
      line_break.disabled = false;

      format = lib.concatStrings [
        "[](color_orange)"
        "$os$username$hostname"
        "[](bg:color_yellow fg:color_orange)"
        "$directory"
        "[](fg:color_yellow bg:color_blue)"
        "$c$rust$python$haskell"
        "[](bg:color_bg3 fg:color_blue)"
        "$git_branch$git_status"
        "[](bg:color_bg1 fg:color_bg3)"
        "$time"
        "[ ](fg:color_bg1)"
        "$line_break$character"
      ];
    };
  };
}
