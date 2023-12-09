local cmp = require("cmp")

cmp.setup({
    snippet = {
            expand = function(args)
                    require("luasnip").lsp_expand(args.body)
            end,
    },
    sources = {
            {name = "cmp_zotcite"},
    },
    mapping = {
            ['<C-Space>'] = cmp.mapping.confirm{
                    behavior = cmp.ConfirmBehavior.Insert,
                    select = true,
            },
    }
})
