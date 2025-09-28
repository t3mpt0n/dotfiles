{
  pkgs,
  config,
  ...
}: {
  age = {
    secrets = {
      pemail = {
        file = ../../age/pemail.age;
      };
      remail = {
        file = ../../age/remail.age;
      };
    };

    secretsDir = "${config.xdg.dataHome}/agenix/agenix";
    secretsMountPoint = "${config.xdg.dataHome}/agenix/agenix.d";
  };
}
