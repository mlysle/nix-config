{ pkgs, inputs, config, ... } :

{
  programs.firefox = {
    enable = true;
    policies = {
      AppAutoUpdate = false;
      BackgroundAppUpdate = false;
      OfferToSaveLogIns = false;
      DefaultDownloadDirectory = "${config.home.homeDirectory}/inbox";
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
          install_url       = "https://github.com/akhodakivskiy/VimFx/releases/download/v0.27.5/VimFx.xpi";
          installation_mode = "force_installed";
          updates_disabled  = true;
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
