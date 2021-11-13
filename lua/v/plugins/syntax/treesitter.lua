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

-- TODO: setup indenting for TSX
-- https://github.com/MaxMEllon/vim-jsx-pretty ???
-- https://www.reddit.com/r/neovim/comments/mgyfys/tressitter_query_can_i_specify_vimpolyglot/gt01lnf/
-- TODO: maybe remove "syntax on" from settings

require('nvim-treesitter.configs').setup({
    ensure_installed = parsers,

    autopairs = { enable = true },
    autotag = { enable = true },
    context_commentstring = { enable = true },
    highlight = { enable = true },
    indent = { enable = true },
    matchup = { enable = true },

    rainbow = {
        enable = true,
        extended_mode = true,
    },
})
