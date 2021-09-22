vim.g.coq_settings = {
    auto_start = 'shut-up',

    keymap = {
        recommended     = false,
        manual_complete = '<c-space>',
        bigger_preview  = '<c-l>',
        jump_to_mark    = '<c-w>'
    },

    clients = {
        buffers = {
            match_syms = true,
        }
    },

    display = {
        ghost_text = {
            enabled = true,
            context = {" 〈 ", " 〉"},
            highlight_group = 'Comment',
        },

        pum = {
            kind_context = {'  ', ''}, -- {" [", "]"}
        },

        icons = {
            mode = 'short',
            mappings = {
                Boolean       = "",
                Character     = "",
                Class         = "ﴯ",
                Color         = "",
                Constant      = "",
                Constructor   = "",
                Enum          = "",
                EnumMember    = "",
                Event         = "",
                Field         = "ﰠ",
                File          = "",
                Folder        = "ﱮ",
                Function      = "",
                Interface     = "",
                Keyword       = "",
                Method        = "",
                Module        = "",
                Number        = "",
                Operator      = "",
                Parameter     = "ﬦ",
                Property      = "ﰠ",
                Reference     = "",
                Snippet       = "",
                String        = "",
                Struct        = "פּ",
                Text          = "",
                TypeParameter = "",
                Unit          = "塞",
                Value         = "",
                Variable      = ""},
        }
    }
}

require('coq')

map('i', '<Esc>', [[pumvisible() ? "\<C-e>"     : "\<Esc>"]], { expr = true, nnoremap = false })
map('i', '<C-c>', [[pumvisible() ? "\<C-e>"     : "\<C-c>"]], { expr = true                   })
-- map('i', 'jk',   [[pumvisible() ? "\<C-e>jk" : "jk"]], { expr = true, noremap = false })

map('i', '<CR>', 'v:lua.CR()', { expr = true })
map('i', '<BS>', 'v:lua.BS()', { expr = true })

require("coq_3p")({
    {
        src = "nvimlua",
        short_name = "nLUA",
        conf_only = true,
    },
    {
        src = "vimtex",
        short_name = "vTEX",
    },
})

