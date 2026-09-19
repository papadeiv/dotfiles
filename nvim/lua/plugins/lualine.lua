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
    -- Three colours are on the bar at once, taken from the active theme's
    -- `statusline` triplet in lua/theme.lua:
    --   1st  the mode pill (section a) and the clock end (section z)
    --   2nd  the file name (section b) and the location (section y)
    --   3rd  the progress (section x)
    -- The middle (sections c and x) stays transparent.
    --
    -- The colours come from lua/theme.lua, NOT from syntax-highlight groups:
    -- a theme's "String" or "Function" colour does not reliably correspond to
    -- its yellow or its purple.

    local theme_data = require("theme")

    -- Sections x and y need their colours set on the components themselves,
    -- because a lualine theme only defines sections a, b and c.
    --   x (progress) = 3rd colour of the triplet (yellow)
    --   y (location) = 2nd colour of the triplet (light blue)
    local function x_color()
      return { bg = theme_data.statusline()[3], fg = theme_data.bg() }
    end

    local function y_color()
      return { bg = theme_data.statusline()[2], fg = theme_data.bg() }
    end

    -- True only in a real file buffer, so the start screen, the tree, the
    -- terminal and other scratch buffers leave section c empty.
    local function is_file()
      return vim.bo.buftype == "" and vim.api.nvim_buf_get_name(0) ~= ""
    end

    local function build_theme()
      local triplet = theme_data.statusline()
      local normal_hl = vim.api.nvim_get_hl(0, { name = "Normal", link = false })
      local text = normal_hl.fg and string.format("#%06x", normal_hl.fg) or "#ffffff"
      local dark = theme_data.bg() -- text drawn on top of the coloured pills
      local base_hl = vim.api.nvim_get_hl(0, { name = "ColorColumn", link = false })
      local base = base_hl.bg and string.format("#%06x", base_hl.bg) or "#3b4252"

      local filled = {
        a = { fg = dark, bg = triplet[1], gui = "bold" },
        b = { fg = dark, bg = triplet[2] },
        c = { fg = text, bg = "NONE" },
      }

      local theme = {}
      for _, mode in ipairs({ "normal", "insert", "visual", "replace", "command", "terminal" }) do
        theme[mode] = vim.deepcopy(filled)
      end
      theme.inactive = { a = { fg = text, bg = base }, b = { fg = text, bg = base }, c = { fg = text, bg = "NONE" } }
      return theme
    end

    local function transparent_theme()
      -- Some themes give Neovim's own status line a background, which would
      -- show through the transparent middle. Remove it.
      for _, group in ipairs({ "StatusLine", "StatusLineNC" }) do
        local hl = vim.api.nvim_get_hl(0, { name = group, link = false })
        hl.bg = nil
        vim.api.nvim_set_hl(0, group, hl)
      end
      return build_theme()
    end

    -- Status line while the cursor is in the file tree:  NORMAL  Filesystem
    local neo_tree_extension = {
      filetypes = { "neo-tree" },
      sections = {
        lualine_a = { { "mode", separator = { right = "" } } },
        lualine_b = { { function() return "Filesystem" end, separator = { right = "" } } },
      },
    }

    -- Status line while the cursor is in a terminal:  TERMINAL
    local terminal_extension = {
      filetypes = { "toggleterm" },
      sections = {
        lualine_a = { { "mode", separator = { right = "" } } },
      },
    }

    local function setup()
    require('lualine').setup{
            options = {
                    theme = transparent_theme(),
                    icons_enabled = true,
                    component_separators = {left = '', right = ''},
                    section_separators = {left = '', right = ''},
                    globalstatus = true,
            },
            sections = {
                    lualine_a = {{'mode',
                                   separator = {right = ''}
                                }},
                    lualine_b = {{'filename',
                                   path = 0,
                                   symbols = {modified = '󰝦 ',
                                              readonly = '',
                                              unnamed = '󱍢 ',
                                              newfile = '󰎔 ',
                                             },
                                   separator = {right = ''}
                                }},
                    lualine_c = {{'filetype',
                                   color = {fg = '#ffffff'},
                                   cond = is_file
                                }},
                    lualine_x = {{'progress',
                                   color = x_color(),
                                   separator = {left = ''}
                                }},
                    lualine_y = {{'location',
                                   color = y_color(),
                                   separator = {left = ''}
                                }},

                    lualine_z = {{'datetime',
                                  style = "%H:%M:%S  %d/%m/%y"
                                }},
            },
            extensions = { neo_tree_extension, terminal_extension },
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
