-- ============================================================================
-- plugins/lualine.lua: bottom status line
-- ============================================================================
-- https://github.com/nvim-lualine/lualine.nvim
-- The layout below is your previous lualine.lua. The colours follow the active
-- colorscheme: coloured ends, transparent middle (see "Colours" below).

return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  lazy = false,
  config = function()
    -- Colours ----------------------------------------------------------------
    -- The ends of the bar (sections a, b, y, z) are filled with colour and the
    -- middle (sections c, x) is transparent, whatever the colorscheme.
    --
    -- If the colorscheme ships a lualine theme with filled ends (catppuccin,
    -- nord, ...), that theme is used. If its theme has no filled ends
    -- (cyberdream's is text-only), one is built from the colorscheme's own
    -- colours instead.

    -- Read a colour from a highlight group, as "#rrggbb" (or nil)
    local function color(group, attr)
      local hl = vim.api.nvim_get_hl(0, { name = group, link = false })
      return hl[attr] and string.format("#%06x", hl[attr]) or nil
    end

    -- Build a theme with filled ends from the colorscheme's highlight groups
    local function built_theme()
      local text = color("Normal", "fg") or "#ffffff"
      local dark = color("Pmenu", "bg") or color("NormalFloat", "bg") or "#1e1e2e" -- text on the coloured ends
      local surface = color("Visual", "bg") or "#3b4252" -- second, darker pill
      local accents = { -- colour of the mode pill in each mode
        normal = color("Function", "fg"),
        insert = color("String", "fg"),
        visual = color("Statement", "fg"),
        replace = color("DiagnosticError", "fg"),
        command = color("Constant", "fg"),
        terminal = color("Type", "fg"),
      }
      local theme = {}
      for mode, accent in pairs(accents) do
        theme[mode] = {
          a = { fg = dark, bg = accent or text, gui = "bold" },
          b = { fg = text, bg = surface },
          c = { fg = text, bg = "NONE" },
        }
      end
      theme.inactive = { a = { fg = text, bg = surface }, b = { fg = text, bg = surface }, c = { fg = text, bg = "NONE" } }
      return theme
    end

    local function transparent_theme()
      -- Some themes (e.g. nord) give Neovim's own status line a background,
      -- which shows through the transparent middle. Remove it.
      for _, group in ipairs({ "StatusLine", "StatusLineNC" }) do
        local hl = vim.api.nvim_get_hl(0, { name = group, link = false })
        hl.bg = nil
        vim.api.nvim_set_hl(0, group, hl)
      end

      package.loaded["lualine.themes.auto"] = nil -- re-detect the colorscheme
      local theme = vim.deepcopy(require("lualine.themes.auto"))

      -- Does the colorscheme's theme fill the ends with colour?
      local normal = theme.normal or {}
      local a_bg = normal.a and normal.a.bg
      local c_bg = normal.c and normal.c.bg
      local filled = a_bg and a_bg ~= "NONE" and a_bg ~= c_bg
      if not filled then
        theme = built_theme()
      end

      -- Make the middle transparent
      for _, mode in pairs(theme) do
        if type(mode) == "table" and mode.c then
          mode.c.bg = "NONE"
        end
      end
      return theme
    end

    local function setup()
    require('lualine').setup{
            options = {
                    theme = transparent_theme(),
                    icons_enabled = true,
                    component_separators = {left = '', right = '|'},
                    section_separators = {left = '', right = ''},
                    globalstatus = true,
            },
            sections = {
                    lualine_a = {{'mode',
                                   separator = {right = ''}
                                }},
                    lualine_b = {{'filename',
                                   path = 0,
                                   symbols = {modified = '󰝦 ',
                                              readonly = '󰴅 ',
                                              unnamed = ' 󱍢 ',
                                              newfile = '󰎔 ',
                                             },
                                   separator = {right = ''}
                                }},
                    lualine_c = {{'filetype',
                                   color = {fg = '#ffffff'}
                                }},
                    lualine_x = {{'fileformat',
                                   color = {fg = '#ffffff'},
                                   symbols = {unix = ' '}}},
                    lualine_y = {'branch',
                                {'diff',
                                  colored = true,
                                  diff_color = {
                                    added = 'LuaLineDiffAdd',
                                    modified = 'LuaLineDiffChange',
                                    removed = 'LuaLineDiffDelete'},
                                  symbols = {
                                    added = '+',
                                    modified = '~',
                                    removed = 'x'
                                  },
                                }},

                    lualine_z = {'progress',
                                 'location',
                                {'datetime',
                                  style = "%H:%M:%S  %d/%m/%y"
                                }},
            }
    }
    end

    setup()

    -- Rebuild the bar when the colorscheme changes (e.g. :colorscheme nord)
    vim.api.nvim_create_autocmd("ColorScheme", {
      group = vim.api.nvim_create_augroup("lualine_transparent", { clear = true }),
      callback = setup,
    })
  end,
}
