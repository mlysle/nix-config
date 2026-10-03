{
  config,
  pkgs,
  ...
}:
{
  imports = [
    ./plasma.nix
    ./programs
    ./services
    ./accounts
    ./programs/nvf
  ];

  home.username = "max";
  home.homeDirectory = "/home/max";
  home.stateVersion = "26.05";

  home.sessionVariables = {
    EDITOR = "nvim";
    SUDO_EDITOR = "nvim";
    TERMINAL = "kitty";
  };

  home.packages = with pkgs; [
    wget
    wl-clipboard
    #yubikey-manager
    #yubikey-personalization
    wineWow64Packages.waylandFull
    strawberry
    appimage-run
    dotnet-sdk_10
    typst
    python3
  ];

  # Enable SafeEyes
  # services.safeeyes.enable = true;

  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    pinentry.package = pkgs.pinentry-curses;
  };

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "text/html" = [ "firefox.desktop" ];
      "x-scheme-handler/http" = [ "firefox.desktop" ];
      "x-scheme-handler/https" = [ "firefox.desktop" ];
      "x-scheme-handler/about" = [ "firefox.desktop" ];
      "x-scheme-handler/unknown" = [ "firefox.desktop" ];
    };
  };

  xdg.userDirs = {
    enable = true;
    createDirectories = true;
    documents = "${config.home.homeDirectory}/doc";
    download = "${config.home.homeDirectory}/inbox";
    desktop = "${config.home.homeDirectory}/inbox";
    music = "${config.home.homeDirectory}/media/music";
    videos = "${config.home.homeDirectory}/media/vids";
    pictures = "${config.home.homeDirectory}/media/pics";
    projects = "${config.home.homeDirectory}/workshop";
    publicShare = null;
    templates = null;
  };

  xdg.terminal-exec = {
    enable = true;
    settings = {
      default = [
        "kitty.desktop"
      ];
    };
  };
}
