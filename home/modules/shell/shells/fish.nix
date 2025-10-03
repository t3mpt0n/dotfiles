{
  lib,
  config,
  pkgs,
  ...
}: {
  programs.fish = {
    enable = lib.mkDefault false;
    interactiveShellInit = ''
    if [ "$INSIDE_EMACS" = 'vterm' ]
      function clear
          vterm_printf "51;Evterm-clear-scrollback";
          tput clear;
      end
    end
    '';

    plugins = [
      {
        name = "autopair";
        src = pkgs.fetchFromGitHub {
          owner = "jorgebucaran";
          repo = "autopair.fish";
          rev = "v1.0.4";
          hash = "";
        };
      }
    ];

    functions = {
      vterm_printf = ''
      if begin; [  -n "$TMUX" ]  ; and  string match -q -r "screen|tmux" "$TERM"; end
          # tell tmux to pass the escape sequences through
          printf "\ePtmux;\e\e]%s\007\e\\" "$argv"
      else if string match -q -- "screen*" "$TERM"
          # GNU screen (screen, screen-256color, screen-256color-bce)
          printf "\eP\e]%s\007\e\\" "$argv"
      else
          printf "\e]%s\e\\" "$argv"
      end
      '';
    };
  };
}
