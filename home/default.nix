{
  inputs,
  ...
}: {
  home = {
    username = "jd";
    homeDirectory = "/home/jd";
    stateVersion = "23.11";
    extraOutputsToInstall = [ "doc" "devdoc" ];
  };

  programs.home-manager.enable = true;
}
