{
  pkgs,
  ...
}: {
  home.packages = with pkgs; let
    gaming_apps = with pkgs; [
      parsec-bin
      lutris
      steam-rom-manager
      protontricks
      protonup-qt
      heroic-unwrapped
      gamemode
      pegasus-frontend
      iortcw
      mangohud
      dualsensectl
      atlauncher
      trigger-control
      mame
      mame-tools
      gamepad-tool
      lunar-client
      osu-lazer-bin
      prismlauncher
      retrofe
      alvr
      lunar-client
      gdlauncher-carbon
      runelite
    ];

    compression_apps = with pkgs; [
      p7zip
      unrar
      unzip
    ];

    libreoffice = with pkgs; [
      libreoffice-qt6-fresh
      jre
    ];

    wine = with pkgs; [
      wineWowPackages.stableFull
      mono
      winetricks
    ];

    tidal = with pkgs; [
      tidal-dl
      tidal-hifi
    ];

    discord = with pkgs; [
      discord
      discord-rpc
      vesktop
    ];
  in [
    yt-dlp
    zathura
    kicad
    hdl-dump
    keepassxc
    keepassxc-go
    qbittorrent
    strawberry
    vlc
    zotero
    pavucontrol
    streamrip
    kid3-qt
    telegram-desktop
  ] ++ games ++ compression_apps ++ libreoffice ++ wine ++ discord;
  
  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
      input-overlay
      obs-pipewire-audio-capture
    ];
  };

  programs.zathura.enable = true;
  programs.mpv.enable = true;
}
