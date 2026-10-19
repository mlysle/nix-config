{
  programs.kitty = {
    enable = true;
    enableGitIntegration = true;
    shellIntegration.enableBashIntegration = true;
    # font.name = "FiraCode Nerd Font Mono";
    # font.size = 20;
    settings = {
      confirm_os_window_close = 0;
    };
    extraConfig = ''
      cursor_trail 1
      custom_shaders cursor-trail-lightning
    '';
  };
}
