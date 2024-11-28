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
        "media.peerConnection.ice.proxy_only" = true;
        "keyword.enabled" = false;
      };
    };
  };

  home.packages = with pkgs; [
    (floorp.overrideAttrs (finalAttrs: previousAttrs: rec {
      packageVersion = "11.20.0";
      version = "128.5.0";

      src = fetchFromGitHub {
        owner = "Floorp-Projects";
        repo = "Floorp";
        fetchSubmodules = true;
        rev = "v${packageVersion}";
        hash = "sha256-+FVnG8CKEQdFN9bO8rUZadp+d8keCB98T7qt9OBfLDA=";
      };
    }))
  ];
}
