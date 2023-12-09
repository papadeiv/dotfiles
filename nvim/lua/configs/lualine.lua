local custom_theme = require'lualine.themes.base16'

custom_theme.normal.c.bg = 'None'

require('lualine').setup{
        options = {
                icons_enabled = true,
                theme = custom_theme,
                component_separators = {left = ' ', right = '|'},
                section_separators = {left = '', right = ' '},
                globalstatus = true,
        },
        sections = {
                lualine_a = {'mode'},
                lualine_b = {{'filename', 
                               path = 0,
                               symbols = {modified = '󰝦 ',
                                          readonly = '󰴅 ',
                                          unnamed = ' 󱍢 ',
                                          newfile = '󰎔 ',
                                         }, 
                            }},
                lualine_c = {{'filetype',
                               color = {fg = '#ffffff'}
                            }},
                lualine_x = {{'fileformat',
                               color = {fg = '#ffffff'},
                               symbols = {unix = ' '}}},
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
                              }
                            }},

                lualine_z = {'progress',
                             'location',
                            {'datetime',
                              style = "%H:%M:%S  %d/%m/%y" 
                            }},
        }
}
