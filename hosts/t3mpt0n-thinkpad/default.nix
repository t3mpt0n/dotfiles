{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./na-init/disko.nix
    ./network.nix
    ./users.nix
    ./gitea.nix
    ./wireguard.nix
  ];
  nix.settings.sandbox = true;
  environment.systemPackages = with pkgs; [
    neovim
    wget
    file
    psmisc
    htop
    unrar
  ];

  services = {
    logind.lidSwitchExternalPower = "ignore";
    dbus = {
      enable = true;
      packages = [ pkgs.gcr ];
    };
    postgresql = {
      enable = true;
    };
  };
}
