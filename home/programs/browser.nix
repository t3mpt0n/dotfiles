{
  pkgs,
  ...
}: {
  programs.librewolf = {
    enable = true;
    settings = {
      "privacy.resistFingerprinting" = true;
      "identity.fxaccounts.enabled" = false;
      "privacy.clearOnShutdown.history" = true;
      "privacy.clearOnShutdown.downloads" = true;
    };
  };

  programs = {
    firefox = {
      enable = true;
    };
  };
}
