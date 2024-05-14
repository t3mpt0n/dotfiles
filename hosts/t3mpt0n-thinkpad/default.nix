{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./discos.nix
  ];
  nix.settings.sandbox = true;
  networking.hostName = "thinkpad";
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
  };
}
