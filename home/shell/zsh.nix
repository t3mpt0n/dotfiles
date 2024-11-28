{
  pkgs,
  lib,
  ...
}: {
  programs.zsh = {
    enable = true;
    shellAliases = import ./alias.nix;
    antidote = {
      enable = true;
      plugins = [
        "zsh-users/zsh-autosuggestions"
        "zsh-users/zsh-syntax-highlighting"
      ];
    };

    envExtra = ''
      if [[ $- == *i* ]]; then
        fastfetch
      fi
      if [[ "$INSIDE_EMACS" = 'vterm' ]]; then
        alias clear='vterm_printf "51;Evterm-clear-scrollback";tput clear'
      fi

      if command -v nix-your-shell > /dev/null; then
        ${pkgs.nix-your-shell}/bin/nix-your-shell zsh | source /dev/stdin
      fi
    '';
  };
}
