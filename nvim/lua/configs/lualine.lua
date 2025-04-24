local custom_theme = require'lualine.themes.palenight'

custom_theme.normal.c.bg = 'None'

require('lualine').setup{
        options = {
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
