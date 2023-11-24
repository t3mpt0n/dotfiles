{
  pkgs,
  inputs,
  lib,
  config,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./nextcloud.nix
    ./discos.nix
    ./gpu.nix
    ./polkit.nix
    ./bluetooth.nix
    ./steam.nix
    ./ssh.nix
  ];
  nixpkgs.config.allowUnfreePredicate = d: builtins.elem (lib.getName d) [
    "unrar"
    "discord"
    "discord-canary"
    "steam"
    "steam-run"
    "steam-original"
  ];

  nix.settings.sandbox = true;

  networking.hostName = "t3mpt0n";

  boot = {
    kernelPackages = pkgs.linuxPackages_zen;
    extraModulePackages = with config.boot.kernelPackages; [ v4l2loopback.out ];
    kernelModules = [ "v4l2loopback" ];
    loader = {
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };
      grub = {
        enable = true;
        device = "nodev";
        efiSupport = true;
        extraEntries = ''
          menuentry "Reboot" {
            reboot
          }
          menuentry "Poweroff" {
            halt
          }
        '';
      };
    };
  };

  environment.systemPackages = with pkgs; [
    neovim
    wget
    openssh
    git
    htop
    psmisc
    doas
    gnupg
    pinentry
    gnumake
    usbutils
    libgccjit
    lsb-release
    xdg-utils
    file
    lm_sensors
    (python311.withPackages (p: with p; [
      regex
      pip
      xmltodict
    ]))
    polkit_gnome
    jq
    unzip
    (pkgs.SDL2.override (old: { waylandSupport = true; x11Support = false; openglSupport = true; pipewireSupport = true; }))
    appimagekit
    appimage-run
    gtk3
    gtk4
    gnome.adwaita-icon-theme
    qt5.qtwayland
    qt6.qtwayland
    unrar
    tree-sitter-grammars.tree-sitter-nix
  ];

  environment = {
    sessionVariables = {
      DOTNET_ROOT = "${pkgs.dotnet-sdk}";
    };
  };

  security = { /* DOAS NOT SUDO */
    doas = {
      enable = true;
      extraRules = [{
        users = [ "jd" ];
        keepEnv = true;
        persist = true;
      }];
    };
    sudo.enable = false;
    tpm2.enable = true; polkit.enable = true;
    pam.services = {
      swaylock.text = ''
        auth include login
      '';
    };
  };

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  programs.noisetorch.enable = true;

  services = {
    dbus = {
      enable = true;
      packages = with pkgs; [
        gcr
        rtkit
      ];
    };
    flatpak.enable = true;
  };

  systemd.extraConfig = ''
    DefaultTimeoutStopSec=10s
  '';

  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = with pkgs; [ xdg-desktop-portal-gtk xdg-desktop-portal-hyprland ];
  };
}
