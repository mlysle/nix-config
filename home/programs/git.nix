{ ...} :

{
  programs.git = {
    enable = true;
    settings.user = {
      name = "Maxwell Lysle";
      email = "max@lysle.org";
    };
    signing = {
      signByDefault = true;
      key = "22D1775D23AAE663";
    };
  };
}
