-- ============================================================================
-- plugins/colorscheme.lua: colour themes
-- ============================================================================
-- To switch theme, change `active` below and restart Neovim.
-- You can also try one without restarting:  :colorscheme nord
--
-- To add a theme, add an entry to `themes` with its GitHub repo and its
-- setup options, then set `active` to its name.
--
-- A theme entry can also have `highlights`: a function returning colour
-- overrides that only apply while that theme is active.

local active = "cyberdream" -- "catppuccin", "nord" or "cyberdream"

-- Mix two "#rrggbb" colours: amount = 1 gives `color`, 0 gives `base`
local function mix(color, base, amount)
  local function channel(hex, i)
    return tonumber(hex:sub(i, i + 1), 16)
  end
  local out = "#"
  for _, i in ipairs({ 2, 4, 6 }) do
    local value = channel(color, i) * amount + channel(base, i) * (1 - amount)
    out = out .. string.format("%02x", math.floor(value + 0.5))
  end
  return out
end

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

  cyberdream = {
    repo = "scottmckendry/cyberdream.nvim",
    setup = function()
      require("cyberdream").setup({ transparent = true })
    end,
    highlights = function()
      local c = require("cyberdream.colors").default -- the cyberdream palette
      return {
        -- Neon purple lines: tree guides, window separators, minimap border
        NeoTreeIndentMarker = { fg = c.purple },
        NeoTreeWinSeparator = { fg = c.purple },
        WinSeparator = { fg = c.purple },
        NeominimapBorder = { fg = c.purple },
        -- Selected text: neon blue mixed with the background so text stays
        -- readable. Raise 0.40 for a stronger blue, lower it for a subtler one.
        Visual = { bg = mix(c.blue, c.bg, 0.40) },
      }
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
}

-- Tweaks applied on top of whichever theme is active ----------------------------
local function apply_tweaks()
  local normal = vim.api.nvim_get_hl(0, { name = "Normal", link = false })
  vim.api.nvim_set_hl(0, "CursorLine", {})                                -- no highlight bar on the cursor line
  vim.api.nvim_set_hl(0, "CursorLineNr", { fg = normal.fg, bold = true }) -- current line number: bold

  -- Per-theme overrides. colors_name can be a variant, e.g. "catppuccin-macchiato".
  for name, theme in pairs(themes) do
    local current = vim.g.colors_name or ""
    if theme.highlights and (current == name or current:find("^" .. name .. "%-")) then
      for group, spec in pairs(theme.highlights()) do
        vim.api.nvim_set_hl(0, group, spec)
      end
    end
  end
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
