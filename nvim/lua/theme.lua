-- ============================================================================
-- theme.lua: the single source of truth for theme colours
-- ============================================================================
-- Not a plugin file (it lives in lua/, not lua/plugins/), so lazy.nvim never
-- loads it directly. plugins/colorscheme.lua, plugins/dashboard.lua and
-- plugins/lualine.lua all `require("theme")` to read this instead of guessing
-- colours from generic syntax-highlight groups (which is what went wrong
-- before: a theme's "String" colour isn't necessarily its yellow).
--
-- To switch theme, change `active` and restart Neovim.
-- To add a theme: add an entry to `themes` with its repo, the name it answers
-- to as a colorscheme, its setup options, and its five `accents`, read from
-- the theme's own palette file (not from :highlight groups).

local M = {}

M.active = "pastel" -- "neon" or "pastel"

M.themes = {
  -- Cyberpunk 2077 palette
  pastel = {
    repo = "followLemmi/cyberpunk-2077.nvim",
    colorscheme = "cyberpunk-2077",
    setup = function()
      require("cyberpunk-2077").setup({
        transparent = true,
        italic_comments = true,
        lualine_bold = true,
      })
    end,
    -- from lua/cyberpunk-2077/palette.lua
    accents = {
      purple = "#CB1DCD", -- steel_pink (used everywhere "purple" appears)
      yellow = "#FDF500", -- rich_lemon
      blue = "#37EBF3",   -- electric_blue
      grey = "#6b6360",   -- comment / fg_darker
      magenta = "#E455AE", -- frostbite
    },
    bg = "#272932", -- raisin_black
    -- The three colours the status bar uses, in order: mode / file / branch
    statusline = { "#CB1DCD", "#37EBF3", "#FDF500" },
  },

  -- Neon on near-black
  neon = {
    repo = "scottmckendry/cyberdream.nvim",
    colorscheme = "cyberdream",
    setup = function()
      require("cyberdream").setup({ transparent = true })
    end,
    -- from lua/cyberdream/colors.lua (the "default" flavour)
    accents = {
      purple = "#bd5eff",
      yellow = "#f1ff5e",
      blue = "#5ea1ff",
      grey = "#7b8496",
      magenta = "#ff5ef1",
    },
    bg = "#16181a",
    -- The three colours the status bar uses, in order: mode / file / branch
    statusline = { "#5ea1ff", "#ff5ef1", "#f1ff5e" },
  },
}

-- The accents of whichever theme is active
function M.accents()
  return M.themes[M.active].accents
end

-- The active theme's background, used for mixing
function M.bg()
  return M.themes[M.active].bg or "#000000"
end

-- The active theme's three status-bar colours
function M.statusline()
  return M.themes[M.active].statusline
end

-- Mix two "#rrggbb" colours: amount = 1 gives `a`, 0 gives `b`
function M.mix(a, b, amount)
  local out = "#"
  for _, i in ipairs({ 2, 4, 6 }) do
    local value = tonumber(a:sub(i, i + 1), 16) * amount + tonumber(b:sub(i, i + 1), 16) * (1 - amount)
    out = out .. string.format("%02x", math.floor(value + 0.5))
  end
  return out
end

return M
