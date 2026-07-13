{config, pkgs, inputs,  ... }:

{
  imports = [
    inputs.nvf.homeManagerModules.default
    inputs.agenix.homeManagerModules.default
    ./plasma.nix
    ./programs
    ./services
    ./accounts
  ];

  home.username = "max";
  home.homeDirectory = "/home/max";
  home.stateVersion = "26.05";

  home.packages = with pkgs; [
    wget
    wl-clipboard
    #yubikey-manager
    #yubikey-personalization
    wineWow64Packages.waylandFull
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

  programs.nvf = {
    enable = true;
    settings = {
      vim.viAlias = true;
      vim.vimAlias = true;
      vim.clipboard = {
        enable = true;
        providers.wl-copy.enable = true;
        registers = "unnamedplus";
      };
      vim.lsp.enable = true;
      vim.formatter.conform-nvim = {
        enable = true;
        presets.nixfmt.enable = true;
      };
      vim.utility  = {

      };
      vim.options = {
        smartindent = true;
        tabstop = 2;
        shiftwidth = 2;
      };
      vim.theme = {
        enable = true;
        name = "catppuccin";
        style = "macchiato";
      };
      vim.treesitter.enable = true;
      vim.languages = {
        enableTreesitter = true;
        nix = {
          enable = true;
          lsp.servers = ["nixd"]; 
          format.type = ["nixfmt"]; 
        };
      };
      vim.notes.neorg = {
        enable = true;
        setupOpts = {
          load = {
            "core.journal".config.strategy = "flat";
            "core.dirman".config = {
              workspaces.notes = "~/doc/notes/neorg/notes";
              default_workspace = "notes";
            };
          };
        };
        treesitter.enable = true;
      };
    };
  };
}
