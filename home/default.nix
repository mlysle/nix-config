{
  config,
  pkgs,
  inputs,
  ...
}: {
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
      "text/html" = ["firefox.desktop"];
      "x-scheme-handler/http" = ["firefox.desktop"];
      "x-scheme-handler/https" = ["firefox.desktop"];
      "x-scheme-handler/about" = ["firefox.desktop"];
      "x-scheme-handler/unknown" = ["firefox.desktop"];
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
      vim.lsp = {
        enable = true;
        formatOnSave = true;
      };
      vim.formatter.conform-nvim = {
        enable = true;
        presets.nixfmt.enable = true;
        presets.csharpier.enable = true;
        setupOpts = {
          formatters_by_ft = {
            cs = ["csharpier"];
            nix = ["nixfmt"];
          };
          format_on_save = {
            timeout_ms = 1000;
            lsp_fallback = false; # Prevents the LSP from stepping in if anything goes wrong
          };
        };
      };
      vim.utility = {
        oil-nvim = {
          enable = true;
          gitStatus.enable = true;
        };
      };
      vim.options = {
        smartindent = true;
        tabstop = 2;
        shiftwidth = 2;
      };
      vim.keymaps = [
        {
          key = "x";
          mode = "n";
          silent = true;
          action = "\"_x";
        }
        {
          key = "X";
          mode = "n";
          silent = true;
          action = "\"_X";
        }
        {
          key = "c";
          mode = "n";
          silent = true;
          action = "\"_c";
        }
        {
          key = "C";
          mode = "n";
          silent = true;
          action = "\"_C";
        }
        # oil
        {
          key = "-";
          mode = "n";
          silent = true;
          action = "<cmd>Oil<CR>";
        }

        # dial
        {
          key = "<C-a>";
          mode = "x";
          silent = true;
          lua = true;
          action = "function() require('dial.map').manipulate('increment', 'visual') end";
        }

        {
          key = "<C-x>";
          mode = "x";
          silent = true;
          lua = true;
          action = "function() require('dial.map').manipulate('decrement', 'visual') end";
        }

        {
          key = "<C-a>";
          mode = "n";
          silent = true;
          lua = true;
          action = "function() require('dial.map').manipulate('increment', 'normal') end";
        }

        {
          key = "<C-x>";
          mode = "n";
          silent = true;
          lua = true;
          action = "function() require('dial.map').manipulate('decrement', 'normal') end";
        }
      ];
      vim.theme = {
        enable = true;
        name = "catppuccin";
        style = "macchiato";
      };
      vim.visuals = {
        rainbow-delimiters.enable = true;
      };
      vim.treesitter.enable = true;
      vim.languages = {
        enableTreesitter = true;
        # enableFormat = true;
        nix = {
          enable = true;
          lsp.servers = ["nixd"];
          # format.type = ["nixfmt"];
        };
        csharp = {
          enable = true;
          # format.enable = true;
          # format.type = ["csharpier"];
        };
        python = {
          enable = true;
        };
        typst = {
          enable = true;
          extensions = {
            # typst-concealer = false;
            typst-preview-nvim = {
              enable = true;
              setupOpts = {
                invert_colors = "auto";
              };
            };
          };
        };
      };
      vim.notes.neorg = {
        enable = true;
        setupOpts = {
          load = {
            "core.defaults".enable = true;
            "core.journal".config.strategy = "flat";
            "core.dirman".config = {
              workspaces.notes = "~/doc/notes/neorg/notes";
              default_workspace = "notes";
            };
          };
        };
        treesitter.enable = true;
      };

      vim.extraPlugins = with pkgs.vimPlugins; {
        "dial.nvim" = {
          package = dial-nvim;
          setup = ''
            local augend = require("dial.augend")
            require("dial.config").augends:register_group{
              default = {
                augend.integer.alias.decimal,
                augend.integer.alias.hex,
                augend.constant.alias.bool,
              },
            }
          '';
        };
      };

      vim.autocomplete.blink-cmp = {
        enable = true;
        friendly-snippets.enable = true;
      };

      vim.diagnostics = {
        enable = true;
        config = {
          signs = true;
          underline = true;
          virtual_text = true;
          virtual_lines = true;
        };
      };
    };
  };
}
