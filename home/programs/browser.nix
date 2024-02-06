{
  pkgs,
  ...
}: {
  programs = {
    firefox = {
      enable = true;
#       profiles = {
#         "nixdef" = {
#           bookmarks = [
#             {
#               name = "Linux";
#               tags = [ "linux" ];
#               keyword = "linux";
#               bookmarks = let
#                 sharedNixTags = [ "linux" "nix" "nixos" ];
#                 in [
#                   {
#                     name = "NixOS";
#                     tags = sharedNixTags;
#                     keyword = "nixos-home";
#                     url = "https://nixos.org/";
#                   } # NixOS Homepage
# 
#                   {
#                     name = "NixOS Wiki";
#                     tags = sharedNixTags ++ [ "wiki" ];
#                     keyword = "nixos-wiki";
#                     url = "https://nixos.wiki/wiki/Main_Page";
#                   } # NixOS Wiki
#               ];
#             }
#           ];
#         };
#       };
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
