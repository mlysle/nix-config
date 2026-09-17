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

        # uBlock Origin
        "uBlock0@raymondhill.net" = {
          install_url       = moz "ublock-origin";
          installation_mode = "force_installed";
          updates_disabled  = true;
        };

        # Multi-Account Containers
        "@testpilot-containers" = {
          install_url       = moz "multi-account-containers";
          installation_mode = "force_installed";
          updates_disabled  = true;
        };

        # VimFx
        "VimFx-unlisted@akhodakivskiy.github.com" = {
          install_url       = "https://github.com/akhodakivskiy/VimFx/releases/download/v0.27.7/VimFx.xpi";
          installation_mode = "force_installed";
          updates_disabled  = true;
        };

        # ClearURLs
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

        # ActivityWatch
        "{ef87d84c-2127-493f-b952-5b4e744245bc}" = {
          install_url       = moz "aw-watcher-web/";
          installation_mode = "force_installed";
          updates_disabled  = true;
        };

        # RSSPreview
        "{7799824a-30fe-4c67-8b3e-7094ea203c94}" = {
          install_url       = moz "rsspreview";
          installation_mode = "force_installed";
          updates_disabled  = true;
        };

        # Cast Kodi
        "castkodi@regseb.github.io" = {
          install_url       = moz "castkodi";
          installation_mode = "force_installed";
          updates_disabled  = true;
        };

        # Simple Tab Groups
        "simple-tab-groups@drive4ik" = {
          install_url       = moz "simple-tab-groups";
          installation_mode = "force_installed";
          updates_disabled  = true;
        };

        # LeechBlock NG
        # "leechblockng@proginosko.com" = {
        #   install_url       = moz "leechblock-ng";
        #   installation_mode = "force_installed";
        #   updates_disabled  = true;
        # };

        # Readeck
        "readeck@readeck.com" = {
          install_url       = moz "readeck";
          installation_mode = "force_installed";
          updates_disabled  = true;
        };

        # Violent Monkey
        "{aecec67f-0d10-4fa7-b7c7-609a2db280cf}" = {
          install_url       = moz "violentmonkey";
          installation_mode = "force_installed";
          updates_disabled  = true;
        };

        # Better Campus
        # "{8927f234-4dd9-48b1-bf76-44a9e153eee0}" = {
        #   install_url       = moz "better-canvas";
        #   installation_mode = "force_installed";
        #   updates_disabled  = true;
        # };
      };

      "3rdparty".Extensions = {
        "leechblockng@proginosko.com" = {
        };

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
          "userFilters" = "en.wikipedia.org###mp-itn\nen.wikipedia.org###mp-itn-h2";
        };
      };
    };
    profiles.default = {
      containersForce = true;
      containers = {
        uw = {
          id = 1;
          color = "green";
          name = "UW";
          icon = "circle";
        };
        lccc = {
          id = 2;
          color = "yellow";
          name = "LCCC";
          icon = "circle";
        };
      };
      settings = {
        "browser.aboutConfig.showWarning" = false;
        "browser.newtabpage.activity-stream.feeds.section.topstories" = false;
        "browser.newtabpage.activity-stream.showSponsored" = false;
        "browser.newtabpage.activity-stream.showSponsoredCheckboxes" = false;
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
        # For Steam Deck
        "media.av1.enabled" = false;
        "browser.startup.page" = 3;
        "browser.toolbars.bookmarks.visibility" = "always";
      };
      bookmarks = {
        # force = true;
        # settings = [
        #   {
        #     name = "Bookmarks Toolbar";
        #     toolbar = true;
        #     bookmarks = [
        #       {
        #         name = "WyoWeb";
        #         url = "https://wyoweb.uwyo.edu/";
        #       }
        #       {
        #         name = "myLCCC";
        #         url = "https://login.classlink.com/my/lccc";
        #       }
        #     ];
        #   }
        # ];
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

          annas-archive = {
            name = "Anna's Archive";
            urls = [{
              template = "https://annas-archive.gd/search";
              params = [
                { name = "q"; value = "{searchTerms}"; }
              ];
            }];
            icon = "https://annas-archive.gd/favicon.ico";
            definedAliases = [ "an" "@annas" ];
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
