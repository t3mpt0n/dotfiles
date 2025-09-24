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
      "DA8FC3FE0B2733276724015481A797678C712F04" # Identity Key
    ];
    extraConfig = ''
      allow-emacs-pinentry
      allow-loopback-pinentry
    '';

    enableZshIntegration = true;
  };
}
