local function config(plugin)
    loadfile('plugins.config.' .. plugin)
end

local M = {
    bufferline      = config('bufferline'),
    colorizer       = config('colorizer'),
    galaxyline      = config('galaxyline'),
    treesitter      = config('treesitter'),
    devicons        = config('devicons'),
    gitsigns        = config('gitsigns'),
    autopairs       = config('autopairs'),
    comment         = config('comment'),
    indentBlankline = config('indent-blankline'),
    fugitive        = config('fugitive'),
}

return M
