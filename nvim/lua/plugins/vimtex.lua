-- ============================================================================
-- plugins/vimtex.lua: LaTeX compilation and editing
-- ============================================================================
-- https://github.com/lervag/vimtex
-- Compile with \ll, view with \lv (or \v), see `:help vimtex-default-mappings`.
-- Errors:   :VimtexErrors  (quickfix list of LaTeX errors, also \le)
-- Log:      :VimtexLog     (vimtex's own messages)
--           the full LaTeX log is <file>.log next to your document
-- Extra LaTeX-only keybindings are in after/ftplugin/tex.lua.

return {
  "lervag/vimtex",
  lazy = false, -- vimtex must not be lazy-loaded (it loads itself for .tex files)

  -- `init` runs before the plugin loads, which is when vimtex reads its settings.
  init = function()
    -- Compile with XeLaTeX where it's installed, otherwise with pdfLaTeX
    -- (latexmk's default). Forcing "-xelatex" on a machine without
    -- texlive-xetex makes every compile fail with "xelatex: not found".
    vim.g.vimtex_compiler_latexmk_engines = {
      _ = (vim.fn.executable("xelatex") == 1) and "-xelatex" or "-pdf",
    }

    -- Compilation errors: show them in the quickfix window, but don't let it
    -- pop open for warnings and overfull-box messages (that's why it used to
    -- be switched off entirely).
    vim.g.vimtex_quickfix_enabled = 1
    vim.g.vimtex_quickfix_open_on_warning = 0
    vim.g.vimtex_quickfix_mode = 2 -- open the window without stealing the cursor

    -- If compiling ever behaves differently from your old setup, pin vimtex to
    -- the version that config used by adding this line to the spec below:
    --   version = "v2.15",
  end,
}
