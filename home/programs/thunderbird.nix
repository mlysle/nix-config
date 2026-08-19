{ ...} :

{
  programs.thunderbird = {
    enable = true;
    profiles.default = {
      isDefault = true;
      withExternalGnupg = true;
      settings = {
        "mailnews.oauth.useExternalBrowser" = true;
        "mail.shell.checkDefaultClient" = false;
        "mail.threadpane.listview" = 1;
        "intl.date_time.pattern_override.time_short" = "h:mm a";
      };
    };
  };
}
