{
  pkgs,
  lib,
  ...
}: {
  programs.firefox = {
    enable = true;
    nativeMessagingHosts = with pkgs; [
      keepassxc
    ];
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
        bookmarks = {
          
        };
        extensions = {
          packages = with pkgs.nur.repos.rycee.firefox-addons; [
            ublock-origin
            keepassxc-browser
            violentmonkey
            darkreader

            ## YouTube
            youtube-shorts-block
            return-youtube-dislikes
            
          ];
          force = true;
        };
        search = {
          engines = {
            ## Package Lookup
            "Nix Packages" = {
              urls = [{
                template = "https://search.nixos.org/packages";
                params = [
                  { name = "type"; value = "packages"; }
                  { name = "query"; value = "{searchTerms}"; }
                ];
              }];
              iconMapObj."16" = "https://nixos.org/favicon.ico";
              definedAliases = [ "@nixpkg" ];
            };

            ## Option Lookup
            "Home Manager Options" = {
              urls = [{
                template = "https://home-manager-options.extranix.com/?query={searchTerms}&release=master";
              }];
              iconMapObj."16" = "https://extranix.com/favicon.ico";
              definedAliases = [ "@hmopt" ];
            };

            "NixOS Options" = {
              urls = [{
                template = "https//search.nixos.org/options?query={searchTerms}&type=packages";
              }];
              definedAliases = [ "@nixopt"];
            };

            ## Wikis
            "NixOS Wiki" = {
               urls = [{ template = "https://wiki.nixos.org/w/index.php?search={searchTerms}"; }];
               iconMapObj."16" = "https://wiki.nixos.org/favicon.ico";
               definedAliases = [ "@nixwiki" ];
            };
            "Unofficial NixOS Wiki" = {
              urls = [{ template = "https://nixos.wiki/index.php?search={searchTerms}&go=Go"; }];
              iconMapObj."16" = "https://nixos.wiki/favicon.ico";
              definedAliases = [ "@nixwikiu" ];
            };
            "Arch Linux Wiki" = {
              urls = [{ template = "https://wiki.archlinux.org/index.php?search={searchTerms}"; }];
              iconMapObj."16" = "https://wiki.archlinux.org/favicon.ico";
              definedAliases = [ "@archwiki" ];
            };
            "Gentoo Wiki" = {
              urls = [{ template = "https://wiki.gentoo.org/index.php?search={searchTerms}"; }];
              iconMapObj."16" = "https://gentoo.org/favicon.ico";
              definedAliases = [ "@gentoowiki" ];
            };

            ## Actual Search Engines
            "Brave Search" = {
              id = "brave";
              urls = [{ template = "https://search.brave.com/search?q={searchTerms}"; }];
              iconMapObj."16" = "https://brave.com/favicon.ico";
              definedAliases = [ "@brave" ];
            };

            "Yandex" = {
              urls = [{ template = "https://yandex.com/search?text={searchTerms}"; }];
              iconMapObj."16" = "https://yandex.com/favicon.ico";
              definedAliases = [ "@yandex" ];
            };

            bing.metadata.hidden = true;
          };
          default = "Brave Search";
          force = true;
        };
      };
    };
  };
}
