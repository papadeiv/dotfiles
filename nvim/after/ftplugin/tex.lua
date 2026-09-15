-- ============================================================================
-- after/ftplugin/tex.lua: extra keybindings for LaTeX files
-- ============================================================================
-- Runs every time a .tex buffer opens. The mappings are buffer-local, so they
-- only exist in LaTeX files. `remap = true` is needed for <Plug> mappings.

local function map(lhs, rhs, desc)
  vim.keymap.set("n", lhs, rhs, { buffer = true, remap = true, desc = desc })
end

map("dsm", "<Plug>(vimtex-env-delete-math)", "Delete surrounding math environment")
map("csm", "<Plug>(vimtex-env-change-math)", "Change surrounding math environment")
map("<localleader>v", "<Plug>(vimtex-view)", "View compiled PDF")
