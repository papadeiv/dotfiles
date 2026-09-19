-- ============================================================================
-- plugins/colorscheme.lua: colour themes
-- ============================================================================
-- The theme data (which themes exist, their accent colours) lives in
-- lua/theme.lua, the single source of truth. This file only turns that data
-- into lazy.nvim plugin specs and applies the small tweaks that use it
-- (tree lines, window separators, the minimap border, selected text).
--
-- To switch theme, change `active` in lua/theme.lua and restart Neovim.
-- You can also try one without restarting:  :colorscheme cyberpunk-2077

local theme = require("theme")

-- Tweaks applied on top of whichever theme is active ----------------------------
local function apply_tweaks()
  local normal = vim.api.nvim_get_hl(0, { name = "Normal", link = false })
  vim.api.nvim_set_hl(0, "CursorLine", {})                                -- no highlight bar on the cursor line
  vim.api.nvim_set_hl(0, "CursorLineNr", { fg = normal.fg, bold = true }) -- current line number: bold

  local active = theme.themes[theme.active]
  local current = vim.g.colors_name or ""
  if current == active.colorscheme or current:find("^" .. active.colorscheme .. "%-") then
    local c = active.accents
    -- Accent lines: tree guides, window separators, minimap border
    vim.api.nvim_set_hl(0, "NeoTreeIndentMarker", { fg = c.purple })
    vim.api.nvim_set_hl(0, "NeoTreeWinSeparator", { fg = c.purple })
    vim.api.nvim_set_hl(0, "WinSeparator", { fg = c.purple })
    vim.api.nvim_set_hl(0, "NeominimapBorder", { fg = c.purple })
    -- Selected text: the theme's blue mixed with its background, so text
    -- underneath stays readable
    vim.api.nvim_set_hl(0, "Visual", { bg = theme.mix(c.blue, theme.bg(), 0.40) })

    -- Transparency: some themes (cyberpunk-2077 among them) give the file
    -- tree and floating windows a solid background even in transparent mode.
    -- Clear them so the terminal shows through, as it does for normal text.
    for _, group in ipairs({
      "NormalFloat", "FloatBorder",
      "NeoTreeNormal", "NeoTreeNormalNC", "NeoTreeEndOfBuffer",
      "NeoTreeFloatNormal", "NeoTreeFloatBorder", "NeoTreeTitleBar",
    }) do
      local hl = vim.api.nvim_get_hl(0, { name = group, link = false })
      hl.bg = nil
      vim.api.nvim_set_hl(0, group, hl)
    end
  end
end

vim.api.nvim_create_autocmd("ColorScheme", {
  group = vim.api.nvim_create_augroup("colorscheme_tweaks", { clear = true }),
  callback = apply_tweaks,
})

-- Build one lazy.nvim spec per theme (no need to edit below this line) -----------
local specs = {}
for name, t in pairs(theme.themes) do
  table.insert(specs, {
    t.repo,
    -- No custom `name`: lazy.nvim derives the install folder from the repo,
    -- which is always unique. (Reusing a hand-picked name here once caused a
    -- theme's plugin folder to be silently left with a DIFFERENT, older
    -- theme's files in it after a rename.)
    lazy = name ~= theme.active, -- only the active theme loads at startup
    priority = 1000,             -- load before other plugins so they pick up its colours
    config = function()
      local ok, err = pcall(t.setup)
      if not ok then
        vim.notify("colorscheme " .. name .. ": " .. err, vim.log.levels.WARN)
        return
      end
      if name == theme.active then
        pcall(vim.cmd.colorscheme, t.colorscheme)
      end
    end,
  })
end

return specs
