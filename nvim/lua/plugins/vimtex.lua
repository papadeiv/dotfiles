-- ============================================================================
-- plugins/vimtex.lua: LaTeX compilation and editing
-- ============================================================================
-- https://github.com/lervag/vimtex
-- Compile with \ll, view with \lv (or \v), see `:help vimtex-default-mappings`.
-- Extra LaTeX-only keybindings are in after/ftplugin/tex.lua.

return {
  "lervag/vimtex",
  lazy = false, -- vimtex must not be lazy-loaded (it loads itself for .tex files)

  -- `init` runs before the plugin loads, which is when vimtex reads its settings.
  init = function()
    vim.g.vimtex_compiler_latexmk_engines = { _ = "-xelatex" } -- compile with XeLaTeX
    vim.g.vimtex_quickfix_enabled = 0 -- don't open the quickfix window on warnings
  end,
}
