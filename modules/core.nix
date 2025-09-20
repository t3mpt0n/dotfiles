{
  pkgs,
  inputs,
  lib,
  ...
}:
let
  systype = "${builtins.currentSystem}";
in
{
  # configuration shared by all hosts
  environment.systemPackages = [
    inputs.agenix.packages.x86_64-linux.agenix
    pkgs.age
    pkgs.clang
    pkgs.cachix
    pkgs.pciutils
  ];

  services.cachix-agent.enable = true;

  documentation.dev.enable = true;

  i18n = {
    defaultLocale = "en_US.UTF-8";
    supportedLocales = [
      "en_US.UTF-8/UTF-8" # AMERICAN ENGLISH
      "es_DO.UTF-8/UTF-8" # DOMINICAN SPANISH
    ];
  };

  # necessary programs
  programs = {
    less.enable = true;
    fish.enable = true;
    zsh.enable = true;
  };

  system = {
    copySystemConfiguration = lib.mkDefault false;
    stateVersion = lib.mkDefault "23.05";
  };

  time.timeZone = lib.mkDefault "America/New_York";

  users.mutableUsers = false;
  users.users.jd = {
    isNormalUser = true;
    initialHashedPassword = "$y$j9T$Wc2D5b6JHhcNSdMaSGxm9.$EvXoES6LlMs/RAyEOILJ3qgn69byBqmtHOvRHgo.a9D";
    shell = pkgs.zsh;
    extraGroups = [
      "input"
      "video"
      "audio"
      "networkmanager"
      "wheel"
    ];
  };
  users.users.root = {
    initialHashedPassword = "$y$j9T$Wc2D5b6JHhcNSdMaSGxm9.$EvXoES6LlMs/RAyEOILJ3qgn69byBqmtHOvRHgo.a9D";
    shell = pkgs.zsh;
  };

  zramSwap.enable = true;
}
