-- TODO: https://github.com/petertriho/cmp-git

local cmp = require('cmp')

require('lspkind').init()

cmp.setup({
    snippet = {
        expand = function(args)
            vim.fn['UltiSnips#Anon'](args.body)
        end,
    },

    mapping = {
        ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
        ['<C-u>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
        ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
        ['<Esc>'] = cmp.mapping({
            i = cmp.mapping.abort(),
            c = cmp.mapping.abort(),
            -- c = cmp.mapping.close(),
        }),
        ['<C-c>'] = cmp.mapping({
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
        }),
        ['<C-e>'] = cmp.mapping({
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
        }),
        ['<CR>'] = cmp.mapping.confirm({ select = false }),
        ['<C-k>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 'c' }),
        ['<C-j>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 'c' }),
        ['<Tab>'] = cmp.mapping({
            i = function(fallback)
                if vim.fn['UltiSnips#CanJumpForwards']() == 1 then
                    vim.fn['UltiSnips#JumpForwards']()
                elseif cmp.visible() then
                    cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
                else
                    fallback()
                end
            end,
        }),
        ['<S-Tab>'] = cmp.mapping({
            i = function(fallback)
                if vim.fn['UltiSnips#CanJumpBackwards']() == 1 then
                    vim.fn['UltiSnips#JumpBackwards']()
                elseif cmp.visible() then
                    cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
                else
                    fallback()
                end
            end,
        }),
    },

    sources = cmp.config.sources({
        { name = 'nvim_lua' },
        { name = 'nvim_lsp' },
        -- { name = 'treesitter' },
        { name = 'path' },
        { name = 'spell' },
        { name = 'cmdline' },
        { name = 'buffer' },
    }),

    completion = {
        autocomplete = true,
    },

    documentation = {
        border = 'single',
    },

    formatting = {
        format = require('lspkind').cmp_format({
            with_text = true,
            maxwidth = 50,
            menu = {
                buffer = '[Buf]',
                nvim_lsp = '[LSP]',
                nvim_lua = '[Lua]',
                path = '[Path]',
                treesitter = '[Treesitter]',
                cmdline = '[CMD]',
            },
        }),
    },

    sorting = {
        comparators = {
            cmp.config.compare.offset,
            cmp.config.compare.exact,
            cmp.config.compare.score,
            require('cmp-under-comparator').under,
            cmp.config.compare.kind,
            cmp.config.compare.sort_text,
            cmp.config.compare.length,
            cmp.config.compare.order,
        },
    },

    experimental = {
        ghost_text = true,
    },
})

local search_sources = {
    sources = cmp.config.sources({
        { name = 'nvim_lsp_document_symbol' },
    }, {
        { name = 'buffer' },
    }),
}

-- use buffer source for `?`
cmp.setup.cmdline('?', search_sources)

-- use buffer source for `/`
cmp.setup.cmdline('/', search_sources)

-- use cmdline and path source for ':'
cmp.setup.cmdline(':', {
    sources = cmp.config.sources({
        { name = 'path' },
    }, {
        { name = 'cmdline' },
    }),
})
