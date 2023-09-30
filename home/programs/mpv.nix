{
  pkgs,
  lib,
  config,
  ...
}: with lib; {
  programs = {
    mpv = {
      enable = true;
      package = pkgs.mpv-unwrapped;
      config = {
        profile = "nix-desktop";
        ytdl-format = "bestaudio+bestvideo";
      };
    };

    yt-dlp = mkIf (config.programs.mpv.enable == true) {
      enable = true;
      package = pkgs.yt-dlp;
      settings = {
        format = "bestvideo*+bestaudio/best";
      };
    };
  };

  nixpkgs.overlays = [
    (self: super: {
      mpv-unwrapped = super.mpv-unwrapped.override {
        pipewireSupport = true;
        vulkanSupport = true;
        jackaudioSupport = true;
        waylandSupport = true;
        scripts = with self.mpvScripts; [
          sponsorblock
          webtorrent-mpv-hook
          quality-menu
        ];
      };
    })
  ];
}
