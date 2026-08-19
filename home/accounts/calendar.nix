{ ... }:

{
  accounts.calendar.accounts.baikal = {
    primary = true;
    remote = {
      type = "caldav";
      url = "https://baikal.lysle.org/dav.php/calendars/mlysle/default/";
      # username = "mlysle";
    };
    thunderbird.enable = true;
  };
}
