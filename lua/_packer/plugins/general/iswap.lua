require('iswap').setup({
    keys         = 'asdfghjklqwertyuiopzxcvbnm', -- keys that'll be used as selection
    grey         = 'enable',                     -- grey out the rest of the text when making a selection
    hl_snipe     = 'Search',                     -- highlight group for the sniping value
    hl_selection = 'Visual',                     -- highlight group for the visual selection of terms
    hl_grey      = 'Comment',                    -- highlight group for the greyed background
    autoswap     = nil                           -- automatically swap with only two arguments
})

