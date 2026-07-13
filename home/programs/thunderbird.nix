{ ...} :

{
  programs.thunderbird = {
    enable = true;
    profiles.default = {
      isDefault = true;
      withExternalGnupg = true;
      settings = {
        "mailnews.oauth.useExternalBrowser" = true;
      };
    };
  };
}
