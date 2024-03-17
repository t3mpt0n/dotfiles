{
  pkgs,
  inputs,
  lib,
  config,
  self,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./nextcloud.nix
    ./discos.nix
    ./gpu.nix
    ./polkit.nix
    ./xdg.nix
    ./vm.nix
    ./cpu.nix
    ./sound.nix
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

  networking.hostName = "t3mpt0n";

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
    neovim
    aircrack-ng
    wget
    git
    htop
    psmisc
    gst_all_1.gstreamer
    gst_all_1.gst-plugins-ugly
    gst_all_1.gst-plugins-good
    gst_all_1.gst-plugins-bad
    gst_all_1.gst-plugins-base
    gst_all_1.gst-vaapi
    doas
    lhasa
    lha
    p7zip
    gnupg
    pinentry
    inetutils
    gnumake
    usbutils
    libgccjit
    lsb-release
    xdg-utils
    self.outputs.packages.x86_64-linux.extract-xiso
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
