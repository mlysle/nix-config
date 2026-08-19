{ ...} :

{
  programs.kitty = {
    enable = true;
    enableGitIntegration = true;
    shellIntegration.enableBashIntegration = true;
    font.name = "FiraCode Nerd Font Mono";
    font.size = 14;
    settings = {
      # confirm_os_window_close = 0;
    };
  };
}
