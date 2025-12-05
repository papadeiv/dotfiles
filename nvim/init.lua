require('options')
require('plugins')
require('configs')
require("luasnip.loaders.from_lua").load({paths = "~/.config/nvim/snippets/"})

-- Disable cursor line
vim.api.nvim_set_hl(0, "CursorLine", { bg = "none", underline = false, bold = false })
vim.api.nvim_set_hl(0, "CursorLineNr", { bg = "none", bold = true})
