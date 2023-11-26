{
  pkgs,
  inputs,
  lib,
  config,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./boot.nix
    ./network.nix
    ./nextcloud.nix
    ./gpu.nix
  ];

  nixpkgs.config.allowUnfreePredicate = d: builtins.elem (lib.getName d) [
    "unrar"
  ];
  nix.settings.sandbox = true;

  environment.systemPackages = with pkgs; [
    neovim
    wget
    file
    lm_sensors
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

  programs.gnupg.agent ={
    enable = true;
    enableSSHSupport = true;
    pinentryFlavor = "tty";
  };
}
