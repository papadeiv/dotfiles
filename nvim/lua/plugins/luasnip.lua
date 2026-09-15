-- ============================================================================
-- plugins/luasnip.lua: snippet engine
-- ============================================================================
-- https://github.com/L3MON4D3/LuaSnip
--
-- Your own snippets live in snippets/<filetype>.lua (e.g. snippets/tex.lua).
-- Keys (insert mode):
--   <Tab>    expand the snippet whose trigger is before the cursor
--   <S-Tab>  jump to the next placeholder
-- In visual mode, <Tab> stores the selection for snippets that use it.

return {
  "L3MON4D3/LuaSnip",
  version = "v2.*",
  build = "make install_jsregexp", -- optional, enables regex-based triggers
  dependencies = { "rafamadriz/friendly-snippets" }, -- ready-made snippets for many languages
  event = "InsertEnter",

  config = function()
    local ls = require("luasnip")

    ls.setup({
      enable_autosnippets = true,
      update_events = { "TextChanged", "TextChangedI" },
      store_selection_keys = "<Tab>",
    })

    -- Load snippets: friendly-snippets, then your own files in snippets/
    require("luasnip.loaders.from_vscode").lazy_load()
    require("luasnip.loaders.from_lua").load({ paths = { vim.fn.stdpath("config") .. "/snippets" } })

    -- Send a key as if it was typed, used when there's nothing to expand/jump.
    local function feed(key)
      vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, false, true), "n", false)
    end

    vim.keymap.set("i", "<Tab>", function()
      if ls.expandable() then
        ls.expand()
      else
        feed("<Tab>")
      end
    end, { desc = "Expand snippet" })

    vim.keymap.set("i", "<S-Tab>", function()
      if ls.jumpable(1) then
        ls.jump(1)
      else
        feed("<S-Tab>")
      end
    end, { desc = "Jump to next snippet placeholder" })
  end,
}
