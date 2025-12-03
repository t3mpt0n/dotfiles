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
      package = pkgs.pinentry-gnome3;
    };
    
    defaultCacheTtl = 0;
    defaultCacheTtlSsh = 0;
    maxCacheTtl = 0;
    maxCacheTtlSsh = 0;
    sshKeys = [
      "0C0A7D9390D2CF3425CFDAFA2CE6304F0013C8A5" # Git Auth Key 1
    ];
    extraConfig = ''
      allow-emacs-pinentry
      allow-loopback-pinentry
    '';
  };

  home.packages = with pkgs; [
    monkeysphere
  ];
}
