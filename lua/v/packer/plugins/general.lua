-- TODO:
-- https://github.com/ThePrimeagen/refactoring.nvim
-- https://github.com/mfussenegger/nvim-dap

local M = {
    -- packer can manage itself as an optional plugin
    {
        'wbthomason/packer.nvim',
        cmd = {
            'PackerClean',
            'PackerCompile',
            'PackerInstall',
            'PackerLoad',
            'PackerProfile',
            'PackerStatus',
            'PackerSync',
            'PackerUpdate',
        },
    },

    -- TODO: doesn't work for some reason
    -- { 'nathom/filetype.nvim' }, -- faster filetype detection

    { 'lewis6991/impatient.nvim' }, -- improve startup time
    { 'antoinemadec/FixCursorHold.nvim' }, -- fixes CursorHold and CursorHoldl
    { 'nvim-lua/plenary.nvim' }, -- great utility lua functions
    { 'editorconfig/editorconfig-vim' }, -- follow .editorconfig files

    { 'chrisbra/NrrwRgn', cmd = { 'NR', 'NUD' } }, -- focus narrow code section
    { 'dstein64/vim-startuptime', cmd = 'StartupTime' }, -- startup profiling
    { 'folke/which-key.nvim', event = 'CursorHold' }, -- displays a popup with keybindings
    { 'max397574/better-escape.nvim', event = 'InsertEnter' }, -- better <Esc> with jk
    { 'milisims/nvim-luaref', ft = 'lua' }, -- lua documentation in :help
    { 'tpope/vim-repeat', keys = '.', fn = 'repeat#set' }, -- enables . repeat for plugins
    { 'wellle/targets.vim', event = 'CursorMoved' }, -- provides great new text objects
    { 'windwp/nvim-autopairs', event = 'InsertEnter' }, -- auto pairs for {[()]}
    { 'AndrewRadev/splitjoin.vim', keys = { 'gS', 'gJ' } }, -- single <-> multi-line

    -- make % smarter
    {
        'andymass/vim-matchup',
        -- keys = {
        --     '%',
        --     'g%',
        --     '[%',
        --     ']%',
        --     'z%',
        -- },
    },

    -- pairs of handy bracket maps
    -- TODO: maybe ditch my fork and just add modifications to my config
    {
        'lucasvianav/vim-unimpaired',
        keys = {
            '[',
            ']',
            '<M-k>',
            '<M-j>',
            '<Space><Space>',
        },
    },

    -- use nvim in the browser
    -- TODO: make this work pls
    {
        'glacambre/firenvim',
        run = function()
            vim.fn['firenvim#install'](0)
        end,
    },

    -- session manager
    -- TODO: work on #69 (https://github.com/rmagatti/auto-session/issues/69)
    -- https://github.com/lucasvianav/auto-session
    -- TODO:
    -- https://github.com/JoosepAlviste/dotfiles/blob/b09a4eed7bf4c7862a02aa8b14ffe29896a0bfa5/config/nvim/lua/j/plugins.lua#L33-L37
    {
        'rmagatti/auto-session',
        event = 'VimLeavePre',
        cmd = {
            'SaveSession',
            'RestoreSession',
            'DeleteSession',
        },
    },

    -- surrounding manipulatiuon maps
    {
        'tpope/vim-surround',
        after = 'vim-repeat',
        event = 'InsertEnter',
        keys = {
            'cs',
            'xs',
            'ds',
            { 'x', 'S' },
            { 'v', 'S' },
        },
    },

    -- like tpope/vim-surround but for functions
    {
        'AndrewRadev/dsf.vim',
        keys = {
            'csf',
            'dsf',
            'dsnf',
            { 'o', 'if' },
            { 'o', 'af' },
        },
    },

    -- word manipulation utilities
    {
        'tpope/vim-abolish',
        cmd = { 'Abolish', 'Subvert' },
        keys = 'cr',
        after = 'vim-repeat',
    },

    -- maps for toggling comments
    -- TODO: swap for numToStr/Comment.nvim
    -- TODO: https://www.reddit.com/r/neovim/comments/q6lq5o/commentnvim_features_go_brrrrr/hgcxcok/?utm_source=reddit&utm_medium=web2x&context=3
    {
        'tpope/vim-commentary',
        cmd = { 'Comment', 'Commentary' },
        keys = { 'gc', { 'v', 'gc' } },
    },

    -- align blocks of code
    -- TODO: checkout tabular?
    -- TODO: invest some time into this
    {
        'junegunn/vim-easy-align',
        cmd = 'EasyAlign',
        keys = '<Leader>a',
    },

    -- better clipboard
    -- TODO: lua port
    -- https://github.com/AckslD/nvim-neoclip.lua
    {
        'svermeulen/vim-easyclip',
        event = { 'CursorMoved', 'InsertEnter' },
        after = 'vim-repeat',
    },

    -- TSDoc docstrings generation
    -- ALTERNATIVE: TODO: kkoomen/vim-doge
    {
        'heavenshell/vim-jsdoc',
        cmd = { 'JsDoc', 'JsDocFormat' },
        keys = '<Leader>j',
        run = 'make install',
    },

    -- multiple cursors
    -- TODO: either ditch this or make it work better
    {
        'mg979/vim-visual-multi',
        as = 'multi',
        keys = { '<C-n>', 'gl', { 'x', '<C-n>' } },
    },

    -- 2-char search motion
    {
        'ggandor/lightspeed.nvim',
        keys = { '<C-s>', '<C-S-s>' },
    },

    -- pulse cursorline after search (easier to find the cursor)
    {
        'inside/vim-search-pulse',
        keys = {
            '/',
            '?',
            'n',
            'N',
            '*',
            '#',
        },
    },

    -- custom "indent block" text object
    {
        'kana/vim-textobj-indent',
        requires = { 'kana/vim-textobj-user' },
        event = 'CursorMoved',
    },

    -- markdown previewer in browser
    -- DEPENDENCY: npm
    {
        'iamcco/markdown-preview.nvim',
        ft = 'markdown',
        run = 'cd app && npm install',
    },

    -- project-wide search and replace
    -- DEPENDENCY: RG, sed
    {
        'windwp/nvim-spectre',
        after = 'plenary.nvim',
        keys = {
            '<Leader>S',
            { 'v', '<Leader>S' },
        },
    },

    -- exchange motions
    -- ALTERNATIVE: mizlan/iswap.nvim
    {
        'tommcdo/vim-exchange',
        keys = {
            'cx',
            'cxx',
            'cxc',
            { 'v', 'X' },
        },
    },
}

return M
