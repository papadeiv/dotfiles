-- ============================================================================
-- plugins/autoclose.lua: automatic bracket pairs
-- ============================================================================
-- https://github.com/m4xshen/autoclose.nvim
-- Same as the previous config, except the " pair, which was written as '"'
-- (one character) and is now '""'.

return {
  "m4xshen/autoclose.nvim",
  event = "InsertEnter",
  opts = {
    keys = {
      -- Brackets (all filetypes)
      ["("] = { escape = true, close = true, pair = "()" },
      ["["] = { escape = true, close = true, pair = "[]" },
      ["{"] = { escape = true, close = true, pair = "{}" },
      ["<"] = { escape = true, close = true, pair = "<>", disabled_filetypes = { "tex" } },
      ['"'] = { escape = true, close = true, pair = '""', disabled_filetypes = { "tex" } },
      ["'"] = { escape = true, close = true, pair = "''", disabled_filetypes = { "tex" } },

      -- LaTeX pairs
      ["$"] = { escape = true, close = true, pair = "$$", enabled_filetypes = { "tex" } },
    },
    options = {
      pair_spaces = true,
      auto_indent = true,
    },
  },
}
