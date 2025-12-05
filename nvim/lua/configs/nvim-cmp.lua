local cmp = require("cmp")

require("luasnip.loaders.from_vscode").lazy_load()

cmp.setup({
        snippet = {
                -- Specify a snippet engine (Luasnip)
                expand = function(args)
                        require('luasnip').lsp_expand(args.body)
                end,
        },
        window = {
                completion = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
                ['<S-j>'] = cmp.mapping.select_next_item(),
                ['<S-k>'] = cmp.mapping.select_prev_item(),
                ['<S-i>'] = cmp.mapping.confirm({ select = true }),
        }),
        sources = cmp.config.sources({
                { name = 'nvim_lsp' },
                { name = 'luasnip' },
                }, {
                { name = 'buffer' },
                })
})
