{ inputs, ... }:
{
  services.spotifyd = {
    enable = true;
    settings = {
      username = "31mocqbs6qljllv2dg5w2kovtlau";
      password_cmd = "cat /etc/.spotifyd";
    };
  };

  programs.spotify-player = {
    enable = true;
  };
}
