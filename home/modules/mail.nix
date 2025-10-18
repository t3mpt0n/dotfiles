{
  pkgs,
  lib,
  config,
  ...
}: {
  programs = {
    mu.enable = true;
    mbsync = {
      enable = true;
    };
    msmtp.enable = true;
    notmuch = {
      enable = true;
      hooks = {
        preNew = lib.mkIf config.programs.mbsync.enable "mbsync -c ~/.config/isyncrc -a";
      };
    };
  };

  sops.secrets = {
    mail-at-t3mpt0n-dot-com = {
      format = "yaml";
      sopsFile = ./crypt/sops/mail.yaml;
    };

    route-at-t3mpt0n-dot-com = {
      format = "yaml";
      sopsFile = ./crypt/sops/mail.yaml;
    };
  };
  
  accounts.email = {
    maildirBasePath = "Mail";
    accounts = {
      personal = {
        enable = true;
        primary = true;
        address = "mail@t3mpt0n.com";
        realName = "Sydney London";
        userName = "mail@t3mpt0n.com";
        passwordCommand = "cat ${config.sops.secrets.mail-at-t3mpt0n-dot-com.path}";

        imap = {
          host = "imap.purelymail.com";
          port = 993;
        };
        smtp = {
          host = "smtp.purelymail.com";
          port = 465;
        };
        gpg.key = "3EAE5C96D8A519B8";

        mbsync = {
          enable = true;
          create = "both";
        };
        mu.enable = true;
        msmtp.enable = true;
        notmuch.enable = true;
      };

      route = {
        enable = true;
        address = "route@t3mpt0n.com";
        realName = "London Sydney";
        userName = "route@t3mpt0n.com";
        passwordCommand = "cat ${config.sops.secrets.route-at-t3mpt0n-dot-com.path}";

        imap = {
          host = "imap.purelymail.com";
          port = 993;
        };
        smtp = {
          host = "smtp.purelymail.com";
          port = 465;
        };
        gpg.key = "0A7A0FFDCBB46AAB";

        mbsync = {
          enable = true;
          create = "both";
        };
        mu.enable = true;
        msmtp.enable = true;
        notmuch.enable = true;
      };
    };
  };

  services = {
    mbsync = {
      enable = true;
      configFile = "${config.xdg.configHome}/isyncrc";
      postExec = "${lib.getExe pkgs.mu} index";
      preExec = "${lib.getExe' pkgs.coreutils "mkdir"} -p ${config.accounts.email.maildirBasePath}";
    };
  };
}
