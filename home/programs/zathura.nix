{ ... }:

{
  programs.zathura = {
    enable = true;
    options = {
      # sandbox = "none";
      statusbar-h-padding = 0;
      statusbar-v-padding = 0;
      page-padding = 1;
      selection-clipboard = "clipboard";
      # default-bg = "rgba(0,0,0,0.7)";
      default-bg = "rgba(0,0,0,1)";
      recolor-lightcolor = "rgba(0,0,0,0)";
    };
    mappings = {
      u = "scroll half-up";
      d = "scroll half-down";
      D = "toggle_page_mode";
      r = "reload";
      R = "rotate";
      Z = "zoom in";
      z = "zoom out";
      i = "recolor";
      p = "print";
      gg = "goto top";
    };
  };
}
