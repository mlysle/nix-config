{
  programs.nvf.settings.vim.keymaps = [
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
    # Typstar
    {
      key = "<LocalLeader>id";
      mode = [
        "n"
      ];
      silent = true;
      lua = true;
      action = "function() require('typstar.drawings').insert_rnote() end";
    }
  ];
}
