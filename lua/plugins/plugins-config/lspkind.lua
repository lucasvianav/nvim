require('lspkind').init({
    with_text = false,          -- enable text along the symbols
    preset    = 'default',     -- 'default' x 'codicons'

    -- overriding preset symbols
    --[[
        symbol_map = {
            Class         = "ﴯ",
            Color         = "",
            Constant      = "",
            Constructor   = "",
            Enum          = "",
            EnumMember    = "",
            Event         = "",
            Field         = "ﰠ",
            File          = "",
            Folder        = "",
            Function      = "",
            Interface     = "",
            Keyword       = "",
            Method        = "",
            Module        = "",
            Operator      = "",
            Property      = "ﰠ",
            Reference     = "",
            Snippet       = "",
            Struct        = "פּ",
            Text          = "",
            TypeParameter = ""
            Unit          = "塞",
            Value         = "",
            Variable      = "",
        },
    ]]--
})
