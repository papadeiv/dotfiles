require("luasnip").config.set_config({
        enable_autosnippets = true,
        update_events = 'TextChanged, TextChangedI',
        store_selection_keys = "<Tab>"
})

vim.cmd[[
 imap <silent><expr> <Tab> luasnip#expandable() ? '<Plug>luasnip-expand-snippet' : '<Tab>'
]]
vim.cmd[[
 imap <silent><expr> <S-Tab> luasnip#jumpable(1) ? '<Plug>luasnip-jump-next' : '<S-Tab>'
]]
