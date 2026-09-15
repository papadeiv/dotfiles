-- ============================================================================
-- plugins/editing.lua: small editing helpers
-- ============================================================================

return {
  -- Surround: add / change / delete brackets, quotes and tags --------------------
  -- https://github.com/kylechui/nvim-surround
  --   ysiw)  surround a word with ()     ds"  delete surrounding quotes
  --   cs'"   change ' to "               S)   (visual mode) surround selection
  -- In .tex files, vimtex's own dse / cse / ds$ / cs$ etc. still work.
  {
    "kylechui/nvim-surround",
    version = "^4.0.0",
    event = "VeryLazy",
    opts = {},
  },

  -- Flash: jump anywhere on screen --------------------------------------------
  -- https://github.com/folke/flash.nvim
  --   s  then type the first letters of where you want to go, then the label
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {
      modes = {
        char = { enabled = false }, -- leave f / F / t / T as standard Neovim
      },
    },
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash jump" },
    },
  },
}
