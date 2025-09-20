{
  pkgs,
  lib,
  ...
}:
{
  programs.zsh = {
    enable = true;
    dotDir = ".config/zsh";
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting = {
      enable = true;
    };
    shellAliases = import ./alias.xtnd;
    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "command-not-found"
        "sudo"
        "cp"
        "direnv"
      ];
    };

    envExtra = ''
      if [[ $- == *i* ]]; then
        ${lib.getExe pkgs.fastfetch}
      fi
      if [[ "$INSIDE_EMACS" = 'vterm' ]]; then
        alias clear='vterm_printf "51;Evterm-clear-scrollback";tput clear'
      fi

      if command -v nix-your-shell > /dev/null; then
        ${pkgs.nix-your-shell}/bin/nix-your-shell zsh | source /dev/stdin
      fi
    '';
  };

  catppuccin.zsh-syntax-highlighting = {
    enable = true;
    flavor = "mocha";
  };
}
