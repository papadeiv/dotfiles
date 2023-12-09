local colorscheme = 'nord'

local status_ok, nord = pcall(vim.cmd, "colorscheme " .. colorscheme)

if not status_ok then
        vim.notify("colorscheme " .. colorscheme .. " not found!")
        return
end

vim.g.nord_contrast = true
vim.g.nord_borders = false
vim.g.nord_disable_background = true 
vim.g.nord_italic = false
vim.g.nord_uniform_diff_background = true
vim.g.nord_bold = true 

require('nord').set()
