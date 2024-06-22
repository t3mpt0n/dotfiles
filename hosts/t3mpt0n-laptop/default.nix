{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuraton.nix
    ./network.nix
    ./na-init/disko.nix
    ./users.nix
  ];
  nix.settings.sandbox = true;
  environment.systemPackages = with pkgs; [
    neovim
    file
    wget
    psmisc
    htop
  ];

  services = {
    logind.lidSwitchExternalPower = "ignore";
    dbus = {
      enable = true;
      packages = [ pkgs.gcr ];
    };
  };
}
