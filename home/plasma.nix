{ inputs, ... }:

{
  imports = [
    inputs.plasma-manager.homeModules.plasma-manager
  ];

  programs.plasma = {
    enable = true;
    workspace = {
      lookAndFeel = "org.kde.breezedark.desktop";
    };
    input.keyboard = {
      options = [ "altwin:swap_alt_win" ];
      repeatDelay = 200;
      repeatRate = 60;

    };
    shortcuts = {
      "kmix" = {
        "decrease_volume" = "Alt+-";
        "increase_volume" = "Alt+=";
        "mute" = "Alt+0";
      };
    };
    kwin.nightLight = {
      enable = true; 
      mode = "automatic"; 
      temperature = {
        day = 6500;
        night = 2700;
      };
    };
  };
}
