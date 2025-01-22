{
  age.secrets = {
    spotifyd = {
      file = ../../../secrets/spotify.age;
      path = "/home/jd/.local/share/spotifyd/.pwd";
      owner = "jd";
      group = "wheel";
    };
  };
}
