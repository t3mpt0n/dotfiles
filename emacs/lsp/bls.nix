  {
    pkgs,
    ...
  }: {
    environment.systemPackages = with pkgs; [
      nodePackages_latest.bash-language-server
    ];
  }
