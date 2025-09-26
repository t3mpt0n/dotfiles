{
  pkgs,
  config,
  ...
}: {
  programs.password-store = {
    enable = true;
    package = pkgs.pass-wayland.withExtensions (exts: with exts; [ # From Here: https://discourse.nixos.org/t/unable-to-use-pass-otp-or-pass-import-with-pass-installed-via-home-manager/50505
      pass-otp
      pass-import
      pass-audit
    ]);
    settings = {
      PASSWORD_STORE_DIR = "${config.xdg.dataHome}/password-store";
      PASSWORD_STORE_CLIP_TIME = "10";
      PASSWORD_STORE_KEY = "3EAE5C96D8A519B8";
    };
  };

  services.pass-secret-service = {
    enable = true;
    storePath = config.programs.password-store.settings.PASSWORD_STORE_DIR;
  };
}
