-- TODO: https://github.com/akinsho/dotfiles/blob/main/.config/nvim/lua/as/plugins/treesitter.lua

-- list of desired treesitter parsers
local parsers = {
    'bash',
    'bibtex',
    'c',
    'comment',
    'css',
    'dockerfile',
    'graphql',
    'html',
    'javascript',
    'jsdoc',
    'tsx',
    'vim',
    'jsonc',
    'json',
    'lua',
    'python',
    'scss',
    'typescript',
    'yaml',
}

require('nvim-treesitter.configs').setup({
    ensure_installed = parsers,

    autopairs             = { enable = true },
    autotag               = { enable = true },
    highlight             = { enable = true },
    context_commentstring = { enable = true },

    rainbow = {
        enable = true,
        extended_mode = true,
    },
})

