{
  programs.kitty = {
    enable = true;
    enableGitIntegration = true;
    shellIntegration.enableBashIntegration = true;
    settings = {
      confirm_os_window_close = 0;
    };
    extraConfig = ''
      cursor_trail 1
      custom_shaders cursor-trail-lightning
      font_family "Fira Code Nerd Font Mono"
      font_size 20.0
    '';
  };
}
