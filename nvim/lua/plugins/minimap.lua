-- ============================================================================
-- plugins/minimap.lua: code minimap
-- ============================================================================
-- https://github.com/Isrothy/neominimap.nvim
-- Plain, documented neominimap setup: no custom code.
--
-- A small map of the file floats in the top-right corner of each file window.
--   <leader>nm  show / hide the minimap
--   <leader>h   move the cursor into / out of the minimap
-- While the cursor is in the minimap, j / k / <C-d> / <C-u> / gg / G move
-- through the file. (From the tree, press <S-Tab> to go to the file first.)

return {
  "Isrothy/neominimap.nvim",
  version = "v3.x.x",
  lazy = false, -- the plugin loads itself lazily

  keys = {
    { "<leader>nm", "<cmd>Neominimap Toggle<cr>", desc = "Toggle minimap" },
    { "<leader>h", "<cmd>Neominimap ToggleFocus<cr>", desc = "Focus / unfocus minimap" },
  },

  -- neominimap reads its settings from vim.g.neominimap before loading
  init = function()
    vim.g.neominimap = {
      auto_enable = true,
      layout = "float",

      -- "percent": the minimap position follows the position in the file
      -- "center":  the current line stays in the middle of the minimap
      current_line_position = "percent",

      float = {
        minimap_width = 20,
        max_minimap_height = 25, -- nil for a full-height minimap
        window_border = "rounded",
      },

      click = { enabled = false }, -- no mouse interaction

      -- Syntax colours in the minimap are off: neominimap applies them in the
      -- background, and when the file changes meanwhile (e.g. format on save)
      -- it errors with "Invalid 'line': out of range". The minimap still shows
      -- the shape of the code, plus errors/warnings and search matches.
      treesitter = { enabled = false },

      exclude_filetypes = { "help", "neo-tree", "toggleterm", "lazy", "mason" },
    }
  end,
}
