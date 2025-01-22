{
  config,
  pkgs,
  lib,
  self,
  ...
}: let
  inherit (self.outputs.packages.x86_64-linux) tmux-ip-address;
in {
  programs.tmux = {
    enable = true;
    shell = "${pkgs.zsh}/bin/zsh";
    terminal = "xterm-256color";
    clock24 = true;
    newSession = true;
    tmuxinator.enable = true;

    plugins = with pkgs.tmuxPlugins; [
      gruvbox
      {
        plugin = tmux-ip-address;
        extraConfig = ''
            set -g status-right "#{ip_address} | #H"
            set -g @ip_adress_refresh_key "P"
            run-shell ${tmux-ip-address}/share/tmux-plugins/tmux-ip-address/ip_address.tmux
          '';
      }
    ];
  };
}
