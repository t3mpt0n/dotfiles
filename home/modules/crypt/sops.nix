{
  lib,
  pkgs,
  config,
  osConfig,
  ...
}: {  
  sops = if config.programs.gpg.enable then {
    gnupg = {
      sshKeyPaths = [];
      home = config.programs.gpg.homedir;
    };
  } else {
    age = {
      keyFile = "${config.xdg.dataHome}/age-key.txt";
    };
  };
}
