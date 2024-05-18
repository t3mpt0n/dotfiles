{
  pkgs,
  inputs,
  lib,
  config,
  self,
  ...
}: let
  inherit (self.inputs.homebrew.packages.x86_64-linux) wut-tools iso2god-rs;
in {
  imports = [
    ./hardware-configuration.nix
    ./nextcloud.nix
    ./discos.nix
    ./gpu.nix
    ./polkit.nix
    ./xdg.nix
    ./vm.nix
    ./cpu.nix
    ./monero.nix
    # ./mpd.nix
    #    ./sound.nix
    ./network.nix
  ];
  nixpkgs.config = {
    allowUnfreePredicate = d: builtins.elem (lib.getName d) [
      "unrar"
      "discord"
      "libretro-fbalpha2012-unstable-2023-11-01"
      "discord-canary"
      "soulseekqt"
      "steam"
      "steam-run"
      "steam-original"
      "lha"
    ];
    permittedInsecurePackages = [
      "freeimage-unstable-2021-11-01"
    ];
  };

  nix.settings.sandbox = true;

  boot = {
    kernelPackages = pkgs.linuxPackages_zen;
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
    aircrack-ng
    wget
    git
    gimx
    arduino
    arduino-cli
    avrdude
    htop
    cdrtools
    psmisc
    glfw-wayland-minecraft
    gst_all_1.gstreamer
    gst_all_1.gst-plugins-ugly
    gst_all_1.gst-plugins-good
    gst_all_1.gst-plugins-bad
    gst_all_1.gst-plugins-base
    gst_all_1.gst-vaapi
    lhasa
    xdelta
    lha
    p7zip
    gnupg
    pinentry
    usbutils
    lsb-release
    xdg-utils
    self.outputs.packages.x86_64-linux.extract-xiso
    wut-tools
    iso2god-rs
    file
    lm_sensors
    (python311.withPackages (p: with p; [
      regex
      pip
      xmltodict
    ]))
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
    tor-browser
    libsForQt5.qt5ct
    libsForQt5.breeze-qt5
    libsForQt5.breeze-icons
    kdePackages.breeze
    kdePackages.breeze-icons
    dotnet-runtime_7
    dotnet-aspnetcore_7
  ];

  environment = {
    sessionVariables = {
      DOTNET_ROOT = "${pkgs.dotnet-sdk}";
    };
  };

  qt.platformTheme = "qt5ct";

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
    tpm2.enable = true;
    polkit.enable = true;
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
    wlr = {
      enable = true;
      settings = {
        screencast = {
          output_name = "DP-3";
          max_fps = 60;
          chooser_cmd = "${pkgs.slurp}/bin/slurp -f %o -or";
          chooser_type = "simple";
        };
      };
    };
    extraPortals = with pkgs; [ xdg-desktop-portal-gtk xdg-desktop-portal-hyprland ];
  };
}
