{
  pkgs,
  lib,
  config,
  ...
}: {
  programs = {
    mbsync = {
      enable = true;
    };

    mu.enable = true;
  };
  
  accounts.email = {
    maildirBasePath = "Mail";
    accounts = {
      personal = {
        enable = true;
        primary = true;
        address = "mail@t3mpt0n.com";
        realName = "Sydney London";
        userName = "personal_mail";
#        passwordCommand = "${lib.getExe' pkgs.coreutils "cat"} ${config.age.secrets.pemail.path}";

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
      };

      route = {
        enable = true;
        address = "route@t3mpt0n.com";
        realName = "London Sydney";
        userName = "routing_mail";
 #       passwordCommand = "${lib.getExe' pkgs.coreutils "cat"} ${config.age.secrets.remail.path}";

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
          extraConfig = {
            account = {
              PassCmd = "${lib.getExe' pkgs.coreutils "cat"} ${config.age.secrets.remail.path}";
            };
          };
        };
        mu.enable = true;
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
