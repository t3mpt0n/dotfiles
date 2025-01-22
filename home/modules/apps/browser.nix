{ pkgs, ... }:
{
  programs = {
    librewolf = {
      enable = true;
      settings = {
        "privacy.resistFingerprinting" = true;
        "identity.fxaccounts.enabled" = false;
        "privacy.clearOnShutdown.history" = true;
        "privacy.clearOnShutdown.downloads" = true;
        "media.peerConnection.ice.proxy_only" = true;
        "keyword.enabled" = false;
      };
    };
  };

  home.packages = with pkgs; [
    floorp
  ];
}
