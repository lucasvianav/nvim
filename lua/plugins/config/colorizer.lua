require('colorizer').setup(
    {'*';}, -- highlight all filetypes
    {
        RGB      = true;         -- #RGB hex codes
        RRGGBB   = true;         -- #RRGGBB hex codes
        names    = true;         -- "name" codes like Blue
        RRGGBBAA = true;         -- #RRGGBBAA hex codes
        rgb_fn   = true;         -- CSS rgb() and rgba()
        hsl_fn   = true;         -- CSS hsl() and hsla()
        css      = true;         -- enable CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
        css_fn   = true;         -- enable CSS functions: rgb_fn, hsl_fn
    }
)

-- vim.cmd("ColorizerReloadAllBuffers")

