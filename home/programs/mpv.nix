{ ... } :

{
  programs.mpv = {
    enable = true;
  };

  xdg.configFile."mpv/scripts/SimpleBookmark.lua" = {
    source = ./SimpleBookmark.lua;
  };
}
