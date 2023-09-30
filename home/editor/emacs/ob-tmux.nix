{
  pkgs,
  config,
  ...
}: {
  home.file.".emacs.d/ob-tmux-defterm.sh" = {
    text = ''
      #!/bin/bash

      ${config.programs.emacs.package}/bin/emacsclient -e "(progn (multi-vterm) (vterm-send-string \"$*\") (vterm-send-return))"
    '';
    executable = true;
  };
}
