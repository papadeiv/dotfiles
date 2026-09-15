-- ============================================================================
-- plugins/ui.lua: diagnostics panel and indent guides
-- ============================================================================

return {
  -- Trouble: list of errors and warnings ---------------------------------------
  -- https://github.com/folke/trouble.nvim
  {
    "folke/trouble.nvim",
    cmd = "Trouble",
    opts = {},
    keys = {
      { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (all files)" },
      { "<leader>xb", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Diagnostics (this file)" },
      { "<leader>xq", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix list" },
    },
  },

  -- Indent guides: vertical lines showing indentation levels -------------------
  -- https://github.com/lukas-reineke/indent-blankline.nvim
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      indent = { char = "│" },
      scope = { enabled = true }, -- highlight the block the cursor is in
      exclude = {
        filetypes = { "help", "neo-tree", "toggleterm", "lazy", "mason", "neominimap" },
      },
    },
  },
}
