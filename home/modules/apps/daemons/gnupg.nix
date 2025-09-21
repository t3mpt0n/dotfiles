{
  pkgs,
  config,
  ...
}: {
  programs.gpg = {
    enable = true;
    homedir = "${config.xdg.dataHome}/gnupg";
  };

  home.sessionVariables = {
    GNUPGHOME = "${config.programs.gpg.homedir}";
  };

  home.packages = [
    pkgs.gcr
  ];

  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    pinentry = {
      package = pkgs.pinentry-gnome3;
    };
    
    defaultCacheTtl = 0;
    defaultCacheTtlSsh = 0;
    maxCacheTtl = 0;
    maxCacheTtlSsh = 0;
    sshKeys = [
      "6BAB375F3CDA44132CAF71A9219822384D4AD1E4" # Git Authentication Key
      "069B2DEEF37B5CD10F1D6B5814F2E9E1F75FC57D" # Git Commit Key
      "DA8FC3FE0B2733276724015481A797678C712F04" # Identity Key
    ];
    extraConfig = ''
      allow-emacs-pinentry
      allow-loopback-pinentry
    '';

    enableZshIntegration = true;
  };
}
