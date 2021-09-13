vim.g.coq_settings = {
    auto_start = 'shut-up',

    keymap = {
        recommended     = false,
        manual_complete = '<c-space>',
        bigger_preview  = '<c-l>',
        jump_to_mark    = '<c-h>'
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

map('i', '<Esc>', [[pumvisible() ? "\<C-e>"     : "\<nop>"]], { expr = true })
map('i', '<C-c>', [[pumvisible() ? "\<C-e>"     : "\<C-c>"]], { expr = true })
map('i', '<BS>',  [[pumvisible() ? "\<C-e><BS>" : "\<BS>"]],  { expr = true })
-- map('i', 'jk',   [[pumvisible() ? "\<C-e>jk" : "jk"]], { expr = true, noremap = false })

-- confirm on Enter
map('i', '<CR>',    [[pumvisible() ? (complete_info().selected == -1 ? "\<C-e><CR>" : "\<C-y>") : "\<CR>"]], { expr = true })

