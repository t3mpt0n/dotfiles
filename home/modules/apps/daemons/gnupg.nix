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

  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    pinentry = {
      package = pkgs.pinentry-qt;
    };
    
    defaultCacheTtl = 0;
    defaultCacheTtlSsh = 0;
    maxCacheTtl = 0;
    maxCacheTtlSsh = 0;
    sshKeys = [
      "6BAB375F3CDA44132CAF71A9219822384D4AD1E4"
      "069B2DEEF37B5CD10F1D6B5814F2E9E1F75FC57D"
      "4FD88E7069CB9601D5FF8BEC399B285597A223D5"
    ];
    extraConfig = ''
      allow-emacs-pinentry
      allow-loopback-pinentry
    '';
    
    enableBashIntegration = true;
    enableZshIntegration = true;
    enableFishIntegration = true;
    enableNushellIntegration = true;
  };
}
