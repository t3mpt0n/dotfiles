{
  pkgs,
  lib,
  ...
}: {
  programs.firefox = {
    enable = true;
    policies = {
      HttpsOnlyMode = "enabled";
      DNSOverHTTPS = {
        Enabled = true;
        ProviderURL = "https://base.dns.mullvad.net";
      };
      AutofillCreditCardEnabled = false;
      AutofillAddressEnabled = false;
      FirefoxSuggest = {
        WebSuggestions = false;
        SponsoredSuggestions = false;
        ImproveSuggest = false;
        Locked = true;
      };
      FirefoxHome = {
        Search = true;
        TopSites = false;
        SponsoredTopSites = false;
        Highlights = false;
        Pocket = false;
        SponsoredPocket = false;
        Snippets = false;
        Locked = true;
      };
      DisablePocket = true;
      DisablePasswordReveal = true;
      DisableTelemetry = true;
      DisableFormHistory = true;
      EnableTrackingProtection = {
        Value = true;
        Locked = true;
        Cryptomining = true;
        Fingerprinting = true;
        EmailTracking = true;
      };
    };

    profiles = {
      day2day = {
        isDefault = true;
        search = {
          engines = {
            ## Package Lookup
            nixpack = {
              name = "Nix Packages";
              urls = [{
                template = "https://search.nixos.packages";
                params = [
                  { name = "type"; value = "packages"; }
                  { name = "query"; value = "{searchTerms}"; }
                ];
              }];

              definedAliases = [ "@nixpkg" ];
            };

            ## Wikis
            nixos-wiki = {
               name = "NixOS Wiki";
               urls = [{ template = "https://wiki.nixos.org/w/index.php?search={searchTerms}"; }];
               iconMapObj."16" = "https://wiki.nixos.org/favicon.ico";
               definedAliases = [ "@nixwiki" ];
            };
            nixos-wiki-unofficial = {
              name = "Unofficial NixOS Wiki";
              urls = [{ template = "https://nixos.wiki/index.php?search={searchTerms}&go=Go"; }];
              iconMapObj."16" = "https://nixos.wiki/favicon.ico";
              definedAliases = [ "@nixwikiu" ];
            };
            arch-wiki = {
              name = "Arch Linux Wiki";
              urls = [{ template = "https://wiki.archlinux.org/index.php?search={searchTerms}"; }];
              iconMapObj."16" = "https://wiki.archlinux.org/favicon.ico";
              definedAliases = [ "@archwiki" ];
            };
            gentoo-wiki = {
              name = "Gentoo Wiki";
              urls = [{ template = "https://wiki.gentoo.org/index.php?search={searchTerms}"; }];
              iconMapObj."16" = "https://gentoo.org/favicon.ico";
              definedAliases = [ "@gentoowiki" ];
            };

            ## Actual Search Engines
            brave-search = {
              name = "Brave Search";
              urls = [{ template = "https://search.brave.com/search?q={searchTerms}"; }];
              iconMapObj."16" = "https://brave.com/favicon.ico";
              definedAliases = [ "@brave" ];
            };

            yandex = {
              name = "Yandex";
              urls = [{ template = "https://yandex.com/search?text={searchTerms}"; }];
              iconMapObj."16" = "https://yandex.com/favicon.ico";
              definedAliases = [ "@yandex" ];
            };

            bing.metadata.hidden = true;
          };
        };
      };
    };
  };
}
