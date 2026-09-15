-- ============================================================================
-- plugins/completion.lua: autocomplete menu
-- ============================================================================
-- https://github.com/saghen/blink.cmp  (stable v1 branch)
--
-- Where suggestions come from:
--   lsp       language servers (see plugins/lsp.lua)
--   snippets  LuaSnip snippets (see plugins/luasnip.lua)
--   path      file paths
--   buffer    words from open files
--   latex     \alpha-style symbols (LaTeX and Julia files only)
--   octave    Octave built-in functions (Octave files only, see lua/sources/octave.lua)
--
-- Keys (insert mode, same as the previous config):
--   <S-j> / <C-n> / <Down>   next item      (<C-n> also opens the menu)
--   <S-k> / <C-p> / <Up>     previous item  (<C-p> also opens the menu)
--   <S-i>                    accept (picks the first item if none is selected)
--   <C-y>                    accept the selected item
--   <C-e>                    close the menu
-- When the menu is closed, each key does what it normally does.

return {
  "saghen/blink.cmp",
  version = "1.*", -- stable release; downloads a prebuilt fuzzy matcher
  dependencies = {
    "L3MON4D3/LuaSnip",
    "erooke/blink-cmp-latex",
  },
  event = "InsertEnter",

  opts = {
    keymap = {
      preset = "none", -- no built-in keys, so <Tab> stays free for LuaSnip
      ["<S-j>"] = { "select_next", "fallback" },
      ["<S-k>"] = { "select_prev", "fallback" },
      ["<S-i>"] = { "select_and_accept", "fallback" },
      ["<C-n>"] = { "select_next", "show" },
      ["<C-p>"] = { "select_prev", "show" },
      ["<Down>"] = { "select_next", "fallback" },
      ["<Up>"] = { "select_prev", "fallback" },
      ["<C-y>"] = { "accept", "fallback" },
      ["<C-e>"] = { "cancel", "fallback" },
    },

    snippets = { preset = "luasnip" },

    completion = {
      menu = { border = "rounded" },
      documentation = {
        auto_show = true, -- show docs for the selected item
        auto_show_delay_ms = 300,
        window = { border = "rounded" },
      },
    },

    -- Show the function signature while typing its arguments
    signature = { enabled = true, window = { border = "rounded" } },

    -- Keep the command line (:) exactly as standard Neovim
    cmdline = { enabled = false },

    sources = {
      default = { "lsp", "snippets", "path", "buffer" },

      -- Extra sources for specific filetypes, on top of the defaults
      per_filetype = {
        tex = { inherit_defaults = true, "latex" },
        julia = { inherit_defaults = true, "latex" },
        octave = { inherit_defaults = true, "octave" },
      },

      providers = {
        latex = {
          name = "LaTeX",
          module = "blink-cmp-latex",
          opts = {
            -- In .tex files insert the command (\alpha); elsewhere insert the
            -- unicode symbol (α), which is how Julia uses them.
            insert_command = function(ctx)
              return vim.bo[ctx.bufnr].filetype == "tex"
            end,
          },
        },
        octave = {
          name = "Octave",
          module = "sources.octave",
        },
      },
    },
  },
}
