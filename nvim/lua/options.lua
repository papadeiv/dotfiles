-- Local options
local set = vim.opt

-- numbers of lhs
vim.wo.number = true

-- qol improvements
set.backspace = '2'
set.showcmd = true

-- use tabs instead of spaces
set.tabstop = 2
set.expandtab = true

-- Editor appearance
vim.api.nvim_set_hl(0, 'FloatBorder', {bg='#3B4252', fg='#5E81AC'})
vim.api.nvim_set_hl(0, 'NormalFloat', {bg='#3B4252'})
vim.api.nvim_set_hl(0, 'TelescopeNormal', {bg='#3B4252'})
vim.api.nvim_set_hl(0, 'TelescopeBorder', {bg='#3B4252'})

set.relativenumber = true
set.cursorline = true

vim.g.termguicolors = true

-- Disable QuickFix Warnings
vim.g.vimtex_quickfix_enabled = 0

-- Transparent central line
vim.g.tpipeline_fillcentre = 0

-- Set Kitty as the in-terminal shell
--vim.o.shell = '/home/papadeiv/.local/kitty.app/bin/kitty'
