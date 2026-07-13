{ pkgs, inputs, config, ... } :

{
  programs.firefox = {
    enable = true;
    policies = {
      AppAutoUpdate = false;
      BackgroundAppUpdate = false;
      OfferToSaveLogIns = false;
      DefaultDownloadDirectory = "${config.home.homeDirectory}/inbox";
      DisablePocket = true;
      DisableTelemetry = true;
      # Extensions
      ExtensionSettings = let
        moz = short: "https://addons.mozilla.org/firefox/downloads/latest/${short}/latest.xpi";
      in {
        "*".installation_mode = "allowed";

        "uBlock0@raymondhill.net" = {
          install_url       = moz "ublock-origin";
          installation_mode = "force_installed";
          updates_disabled  = true;
        };

        "VimFx-unlisted@akhodakivskiy.github.com" = {
          install_url       = "https://github.com/akhodakivskiy/VimFx/releases/download/v0.27.6/VimFx.xpi";
          installation_mode = "force_installed";
          updates_disabled  = true;
        };

        "{74145f27-f039-47ce-a470-a662b129930a}" = {
          install_url       = moz "clearurls";
          installation_mode = "force_installed";
          updates_disabled  = true;
        };

        "{3c6bf0cc-3ae2-42fb-9993-0d33104fdcaf}" = {
          install_url       = moz "youtube-addon";
          installation_mode = "force_installed";
          updates_disabled  = true;
        };

        "{ef87d84c-2127-493f-b952-5b4e744245bc}" = {
          install_url       = moz "aw-watcher-web/";
          installation_mode = "force_installed";
          updates_disabled  = true;
        };

        "{7799824a-30fe-4c67-8b3e-7094ea203c94}" = {
          install_url       = moz "rsspreview";
          installation_mode = "force_installed";
          updates_disabled  = true;
        };
      };

      "3rdparty".Extensions = {
        "{ef87d84c-2127-493f-b952-5b4e744245bc}" = {
          "consentOfflineDataCollection" = true;
        };
        "uBlock0@raymondhill.net".adminSettings = {
          selectedFilterLists = [
            "user-filters"
            "ublock-filters"
            "ublock-badware"
            "ublock-privacy"
            "ublock-quick-fixes"
            "ublock-unbreak"
            "easylist"
            "easyprivacy"
            "urlhaus-1"
            "plowe-0"
            "fanboy-cookiemonster"
            "ublock-cookies-easylist"
            "adguard-cookies"
            "ublock-cookies-adguard"
            "fanboy-social"
            "adguard-social"
            "fanboy-thirdparty_social"
            "fanboy-ai-suggestions"
            "easylist-chat"
            "easylist-newsletters"
            "easylist-notifications"
            "easylist-annoyances"
            "adguard-mobile-app-banners"
            "adguard-other-annoyances"
            "adguard-popup-overlays"
            "adguard-widgets"
            "ublock-annoyances"
          ];
        };
      };
    };
    profiles.default = {
      settings = {
        "browser.newtabpage.activity-stream.feeds.section.topstories" = false;
        "browser.newtabpage.activity-stream.showSponsored" = false;
        "browser.newtabpage.activity-stream.showSponsoredCheckboxes" = false;
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
        # For Steam Deck
        "media.av1.enabled" = false;
        "browser.startup.page" = 3;
      };
      search = {
        force = true;
        default = "brave";
        privateDefault = "brave";
        engines = {
          nix-packages = {
            name = "Nix Packages";
            urls = [{
              template = "https://search.nixos.org/packages";
              params = [
                { name = "type"; value = "packages"; }
                { name = "query"; value = "{searchTerms}"; }
              ];
            }];
            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = [ "@np" ];
          };

          brave = {
            name = "Brave";
            urls = [{
              template = "https://search.brave.com/search";
              params = [
                { name = "q"; value = "{searchTerms}"; }
                { name = "source"; value = "web"; }
              ];
            }];
            icon = "https://cdn.search.brave.com/serp/v3/_app/immutable/assets/favicon.acxxetWH.ico";
            definedAliases = [ "@brave" ];
          };

          modrinth = {
            name = "Modrinth";
            urls = [{
              template = "https://modrinth.com/discover/mods";
              params = [
                { name = "g"; value = "categories:neoforge"; }
                { name = "v"; value = "1.21.1"; }
                { name = "q"; value = "{searchTerms}"; }
              ];
            }];
            icon = "https://modrinth.com/favicon.ico";
            definedAliases = [ "@modrinth" ];
          };

          minecraft = {
            name = "Minecraft Wiki";
            urls = [{
              template = "https://minecraft.wiki";
              params = [
                { name = "search"; value = "{searchTerms}"; }
              ];
            }];
            icon = "https://minecraft.wiki/favicon.ico";
            definedAliases = [ "mc" "@minecraft" ];
          };

          youtube = {
            name = "Youtube";
            urls = [{
              template = "https://youtube.com/results";
              params = [
                { name = "search_query"; value = "{searchTerms}"; }
              ];
            }];
            icon = "https://youtube.com/favicon.ico";
            definedAliases = [ "y" "@youtube" ];
          };
          bing.metaData.hidden = true;
        };
      };
    };
  };

  programs.firefox.package =
    pkgs.firefox.overrideAttrs
    (old: {
      buildCommand = (old.buildCommand or "") + ''
          ln -s ${inputs.legacyfox}/legacy $libDir/
          ln -s ${inputs.legacyfox}/legacy.manifest $libDir/
          ln -sf ${inputs.legacyfox}/config.js $libDir/mozilla.cfg
      '';
    });
}
