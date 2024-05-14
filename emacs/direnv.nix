{
  config,
  lib,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    nix-your-shell
  ];

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
}
