{ pkgs, ... }:
{
  home.file.".emacs.d/early-init.el" = {
    text = ''
      ;Disable package.el
      (setq package-enable-at-startup nil)
    '';
  };
  home.file.".emacs.d/init.el" = {
    text = ''
      (setq create-lockfiles nil)

      ${builtins.readFile ./modules/elpaca.el}
      ${builtins.readFile ./modules/keys.el}
      ${builtins.readFile ./modules/ui.el}
      ${builtins.readFile ./modules/dashboard.el}
      ${builtins.readFile ./modules/cmp.el}
    '';
  };

  programs.emacs = {
    enable = true;
    package = pkgs.emacs30-pgtk;
  };

  services.emacs = {
    enable = true;
    client = {
      enable = true;
      arguments = [
        "-c"
        "-a 'emacs'"
      ];
    };
    defaultEditor = true;
    package = pkgs.emacs30-pgtk;
  };
}
