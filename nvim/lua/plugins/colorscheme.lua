-- ============================================================================
-- plugins/colorscheme.lua: colour themes
-- ============================================================================
-- To switch theme, change `active` below and restart Neovim.
-- You can also try one without restarting:  :colorscheme nord
--
-- To add a theme, add an entry to `themes` with its GitHub repo and its
-- setup options, then set `active` to its name.

local active = "cyberdream"

local themes = {
  catppuccin = {
    repo = "catppuccin/nvim",
    setup = function()
      require("catppuccin").setup({
        flavour = "macchiato", -- latte, frappe, macchiato, mocha
        transparent_background = true,
        styles = {
          comments = { "italic" },
          conditionals = { "italic" },
        },
        auto_integrations = true, -- colour neo-tree, blink.cmp, flash, ... to match
        custom_highlights = function(colors)
          return { LineNr = { fg = colors.overlay2 } } -- the relative numbers
        end,
      })
    end,
  },

  nord = {
    repo = "gbprod/nord.nvim",
    setup = function()
      require("nord").setup({
        transparent = true,
        styles = { comments = { italic = true } },
      })
    end,
  },

  cyberdream = {
    repo = "scottmckendry/cyberdream.nvim",
    setup = function()
      require("cyberdream").setup({
        variant = "default", -- light, muted, auto
        transparent = true,
        saturation = 1,
        italic_comments = true,
        borderless_pickers = true,
        terminal_colors = true,
      })
    end,
  }
}

-- Tweaks applied on top of whichever theme is active ----------------------------
local function apply_tweaks()
  local normal = vim.api.nvim_get_hl(0, { name = "Normal", link = false })
  vim.api.nvim_set_hl(0, "CursorLine", {})                                -- no highlight bar on the cursor line
  vim.api.nvim_set_hl(0, "CursorLineNr", { fg = normal.fg, bold = true }) -- current line number: bold
end

vim.api.nvim_create_autocmd("ColorScheme", {
  group = vim.api.nvim_create_augroup("colorscheme_tweaks", { clear = true }),
  callback = apply_tweaks,
})

-- Build one lazy.nvim spec per theme (no need to edit below this line) -----------
local specs = {}
for name, theme in pairs(themes) do
  table.insert(specs, {
    theme.repo,
    name = name,
    lazy = name ~= active, -- only the active theme loads at startup
    priority = 1000,       -- load before other plugins so they pick up its colours
    config = function()
      theme.setup()
      if name == active then
        vim.cmd.colorscheme(name)
      end
    end,
  })
end

return specs
