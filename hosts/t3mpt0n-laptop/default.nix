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
    # ./network.nix
    ./gpu.nix
  ];

  nixpkgs.config.allowUnfreePredicate = d: builtins.elem (lib.getName d) [
    "unrar"
  ];
  nix.settings.sandbox = true;

  networking.hostName = "t3mpt0n-laptop";

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
