require("autoclose").setup({
      keys = {
          -- Brackets (all filetypes)
          ["("] = {escape = true, close = true, pair = "()"},
          ["["] = {escape = true, close = true, pair = "[]"},
          ["{"] = {escape = true, close = true, pair = "{}"},
          ["<"] = {escape = true, close = true, pair = "<>", disabled_filetypes = {"tex"}},
          ['"'] = {escape = true, close = true, pair = '"', disabled_filetypes = {"tex"}},
          ["'"] = {escape = true, close = true, pair = "''", disabled_filetypes = {"tex"}},

          -- LaTex pairs
          ["$"] = {escape = true, close = true, pair = "$$", enabled_filetypes = {"tex"}},
        },
      options = {
              pair_spaces = true, 
              auto_indent = true,
      },
})
