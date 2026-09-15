-- ============================================================================
-- plugins/lsp.lua: language servers
-- ============================================================================
-- Language servers power autocomplete, go-to-definition, hover docs, errors
-- and warnings.
--
--   mason.nvim            installs servers and tools   (:Mason to browse)
--   mason-lspconfig.nvim  installs + starts the servers listed below
--   nvim-lspconfig        ready-made settings for each server
--
-- To add a language: add its server name (from `:help lspconfig-all`) to
-- `servers` below and restart Neovim.
--
-- Built-in LSP keys (Neovim 0.12 defaults, normal mode):
--   K       hover documentation        <C-]>    go to definition
--   grn     rename symbol              grr      list references
--   gra     code actions               gri      go to implementation
--   grt     go to type definition      gO       list symbols in the file
--   [d / ]d previous / next diagnostic <C-w>d   show diagnostic in a popup

-- Language servers (lspconfig names) -----------------------------------------
local servers = {
  "basedpyright", -- Python       (completion, types)
  "ruff",         -- Python       (linting)
  "clangd",       -- C / C++
  "texlab",       -- LaTeX        (commands, labels, citations)
  "ltex_plus",    -- LaTeX        (grammar and spelling)
}

-- Julia's server is NOT installed through Mason (Mason's Julia package breaks
-- easily). Install it once with Julia itself, as nvim-lspconfig documents:
--   julia --project=~/.julia/environments/nvim-lspconfig -e 'using Pkg; Pkg.add("LanguageServer")'
-- It's only started on machines where `julia` is found.
local julia_available = vim.fn.executable("julia") == 1

-- Extra tools installed through Mason (formatters used by plugins/formatting.lua)
local tools = {
  "clang-format",
}

-- Per-server settings --------------------------------------------------------
-- Anything here is merged on top of nvim-lspconfig's defaults.
local server_settings = {
  ltex_plus = {
    filetypes = { "tex", "bib" }, -- grammar-check LaTeX only
    settings = {
      ltex = {
        language = "en-GB", -- e.g. "en-US", "it", "de-DE"
      },
    },
  },
  ruff = {
    -- basedpyright already provides hover docs
    on_attach = function(client)
      client.server_capabilities.hoverProvider = false
    end,
  },
}

return {
  "mason-org/mason-lspconfig.nvim",
  dependencies = {
    { "mason-org/mason.nvim", opts = { ui = { border = "rounded" } } },
    "neovim/nvim-lspconfig",
  },
  event = { "BufReadPre", "BufNewFile" },
  cmd = { "Mason" },

  config = function()
    -- How errors and warnings are displayed
    vim.diagnostic.config({
      virtual_text = true,   -- message at the end of the line
      severity_sort = true,  -- errors above warnings
      float = { border = "rounded" },
    })

    -- Apply the per-server settings
    for name, settings in pairs(server_settings) do
      vim.lsp.config(name, settings)
    end

    -- Install missing servers and start them automatically
    require("mason-lspconfig").setup({
      ensure_installed = servers,
      automatic_enable = { exclude = { "julials" } },
    })

    -- Julia (installed outside Mason, see the note at the top)
    if julia_available then
      vim.lsp.enable("julials")
    end

    -- Install missing tools
    local registry = require("mason-registry")
    registry.refresh(function()
      for _, name in ipairs(tools) do
        local ok, pkg = pcall(registry.get_package, name)
        if ok and not pkg:is_installed() and not pkg:is_installing() then
          pkg:install()
        end
      end
    end)
  end,
}
