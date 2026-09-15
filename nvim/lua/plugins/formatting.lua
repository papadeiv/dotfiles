-- ============================================================================
-- plugins/formatting.lua: format code on save
-- ============================================================================
-- https://github.com/stevearc/conform.nvim
-- Only the filetypes listed in `format_on_save_filetypes` are formatted
-- automatically. Run :ConformInfo to see which formatter a file would use.

-- Which formatter each filetype uses. Julia has none here on purpose: it falls
-- back to its language server, which formats with JuliaFormatter.
local formatters_by_ft = {
  python = { "ruff_format" },
  c = { "clang-format" },
  cpp = { "clang-format" },
}

local format_on_save_filetypes = {
  python = true,
  c = true,
  cpp = true,
  julia = true,
}

return {
  "stevearc/conform.nvim",
  event = "BufWritePre",
  cmd = "ConformInfo",
  opts = {
    formatters_by_ft = formatters_by_ft,
    format_on_save = function(bufnr)
      if not format_on_save_filetypes[vim.bo[bufnr].filetype] then
        return nil -- don't format this file
      end
      return {
        timeout_ms = 2000,     -- Julia's formatter can be slow
        lsp_format = "fallback", -- use the language server if no formatter is listed
      }
    end,
  },
}
