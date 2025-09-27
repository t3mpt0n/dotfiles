{
  pkgs,
  ...
}: {
  age.secrets = {
    pemail = {
      file = ../../age/pemail.age;
    };
    remail = {
      file = ../../age/remail.age;
    };
  };
}
