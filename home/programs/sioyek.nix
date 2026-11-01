{ ... }:

{
  programs.sioyek = {
    enable = true;
    bindings = {
      screen_down = "<C-d>";
      screen_up = "<C-u>";
      prev_state = "<C-o>";
      toggle_titlebar = "<C-w>";
      next_state = "<C-i>";
      zoom_in = "z";
      zoom_out = "Z";

      toggle_dark_mode = "i";
      toggle_custom_color = "c";
      reload_config = "r";

      fit_to_page_width = "s";

      goto_toc = "<tab>";
      # "goto_top_of_page;goto_right" =
    };
    config = {
      ruler_mode = "1";
      startup_commands = [
        "toggle_dark_mode"
      ];
    };
  };
}
