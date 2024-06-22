{
  age.secrets = {
    nextcloud_admin = {
      file = ../secrets/nextcloud_admin.age;
      owner = "nextcloud";
      group = "nextcloud";
    };
    nextcloud_sydney = {
      file = ../secrets/nextcloud_sydney.age;
      owner = "nextcloud";
      group = "nextcloud";
    };
    cloudflare_creds = {
      file = ../secrets/cloudflare.creds.age;
      owner = "acme";
      group = "acme";
    };
  };
}
