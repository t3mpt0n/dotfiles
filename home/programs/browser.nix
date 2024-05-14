{
  pkgs,
  ...
}: {
  programs = {
    firefox = {
      enable = true;
    };

    librewolf = {
      enable = true;
      settings = {
        "privacy.resistFingerprinting" = true;
        "identity.fxaccounts.enabled" = false;
        "privacy.clearOnShutdown.history" = true;
        "privacy.clearOnShutdown.downloads" = true;
      };
    };
  };
}
