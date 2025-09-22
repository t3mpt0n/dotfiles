{
  pkgs,
  ...
}: {
  home.packages = let
    compression_apps = with pkgs; [
      p7zip
      unrar
      unzip
    ];

    libreo = with pkgs; [
      libreoffice
      jre21_minimal
    ];
  in with pkgs; [
    nicotine-plus
    quodlibet
    yt-dlp
    zathura
    kicad
    hdl-dump
    keepassxc
    keepassxc-go
    qbittorrent
    vlc
    zotero
    pavucontrol
    kid3-qt
    streamrip
  ] ++ compression_apps ++ libreo;
  
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
  programs.vesktop.enable = true;
}
