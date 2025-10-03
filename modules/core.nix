{
  pkgs,
  inputs,
  lib,
  config,
  ...
}:
let
  systype = "${builtins.currentSystem}";
in
  {
    imports = [
      inputs.sops-nix.nixosModules.sops
    ];
    environment.systemPackages = [
      pkgs.age
      pkgs.sops
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

    sops = {
      defaultSopsFile = ../sops/default.json;
      validateSopsFiles = false;

      age = {
        sshKeyPaths = [ "/etc/ssh/sydney" ];
        generateKey = false;
      };

      secrets.jd-pass = {
        format = "json";
        sopsFile = ../sops/users.json;
	neededForUsers = true;
      };
    };
  
    users.mutableUsers = false;
    users.users.jd = {
      isNormalUser = true;
      hashedPasswordFile = config.sops.secrets.jd-pass.path;
      extraGroups = [
        "input"
        "video"
        "audio"
        "networkmanager"
        "wheel"
      ];
    };
    users.users.root = {
      hashedPasswordFile = config.sops.secrets.jd-pass.path;
    };

    zramSwap.enable = true;
  }
