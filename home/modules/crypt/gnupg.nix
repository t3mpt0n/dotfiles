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
      "F89CF58546B97DFD551BFAAC71C09D4DF9C75F8A" # Identity Key
    ];
    extraConfig = ''
      allow-emacs-pinentry
      allow-loopback-pinentry
    '';
  };
}
