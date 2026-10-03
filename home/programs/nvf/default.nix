{ pkgs, inputs, ... }:

{
  imports = [
    inputs.nvf.homeManagerModules.default
    inputs.agenix.homeManagerModules.default
  ];

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
      vim.hideSearchHighlight = true;
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
            cs = [ "csharpier" ];
            nix = [ "nixfmt" ];
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

        # textobjects
        {
          key = "am";
          mode = [
            "x"
            "o"
          ];
          silent = true;
          lua = true;
          action = "function() require('nvim-treesitter-textobjects.select').select_textobject('@function.outer', 'textobjects') end";
        }

        {
          key = "im";
          mode = [
            "x"
            "o"
          ];
          silent = true;
          lua = true;
          action = "function() require('nvim-treesitter-textobjects.select').select_textobject('@function.inner', 'textobjects') end";
        }

        {
          key = "l=";
          mode = [
            "x"
            "o"
          ];
          silent = true;
          lua = true;
          action = "function() require('nvim-treesitter-textobjects.select').select_textobject('@assignment.lhs', 'textobjects') end";
        }

        {
          key = "r=";
          mode = [
            "x"
            "o"
          ];
          silent = true;
          lua = true;
          action = "function() require('nvim-treesitter-textobjects.select').select_textobject('@assignment.rhs', 'textobjects') end";
        }

        {
          key = "igi";
          mode = [
            "x"
            "o"
          ];
          silent = true;
          lua = true;
          action = "function() require('nvim-treesitter-textobjects.select').select_textobject('@conditional.inner', 'textobjects') end";
        }

        {
          key = "agi";
          mode = [
            "x"
            "o"
          ];
          silent = true;
          lua = true;
          action = "function() require('nvim-treesitter-textobjects.select').select_textobject('@conditional.outer', 'textobjects') end";
        }

      ];
      vim.theme = {
        enable = true;
        name = "catppuccin";
        style = "mocha";
      };
      vim.visuals = {
        rainbow-delimiters.enable = true;
      };
      vim.treesitter = {
        enable = true;
        highlight.enable = true;
        indent.enable = true;
        textobjects = {
          enable = true;
          setupOpts = {
            select = {
              enable = true;
              lookahead = true;
            };
          };
        };
      };
      vim.languages = {
        enableTreesitter = true;
        # enableFormat = true;
        nix = {
          enable = true;
          lsp.servers = [ "nixd" ];
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
            "core.esupports.metagen".config = {
              author = "Maxwell Lysle";
              type = "auto";
            };
            "core.integrations.treesitter".config = {
              # Parsers come from the nix wrapper (already on tcs language registry),
              #so neorg must not try to manage them.
              configure_parsers = false;
            };
          };
        };
        treesitter.enable = true;
      };

      vim.extraPlugins = with pkgs.vimPlugins; {
        typstar = {
          package = (
            pkgs.vimUtils.buildVimPlugin {
              name = "typstar";
              src = inputs.typstar;
              buildInputs = with pkgs.vimPlugins; [
                luasnip
                nvim-treesitter-parsers.typst
              ];
            }
          );
          setup = "require('typstar').setup({})";
        };
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
        friendly-snippets.enable = false;
        setupOpts = {
          keymap.preset = "default";
          # I turned off snippets
          sources = {
            default = [
              "lsp"
              "path"
              "snippets"
              "buffer"
            ];
            providers = {
              snippets = {
                opts = {
                  show_autosnippets = false;
                };
              };
            };
          };
        };
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

      vim.snippets.luasnip = {
        enable = true;
        providers = [ "friendly-snippets" ];
        setupOpts = {
          enable_autosnippets = true;
          cut_selection_keys = "<Tab>";
        };
      };
      mnw = {
        enable = true;
        extraLuaPackages = ps: [ ps.jsregexp ];
      };

    };
  };
}
