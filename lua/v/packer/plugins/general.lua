-- TODO: better distribute this plugins
-- https://github.com/gelguy/wilder.nvim
-- https://github.com/kevinhwang91/nvim-bqf
-- https://github.com/ThePrimeagen/refactoring.nvim
-- https://github.com/ThePrimeagen/harpoon

-- TODO: https://github.com/mfussenegger/nvim-dap
-- TODO: https://github.com/puremourning/vimspector

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

    -- TODO: test https://github.com/tami5/impatient.nvim
    { 'lewis6991/impatient.nvim' }, -- improve startup time
    { 'antoinemadec/FixCursorHold.nvim' }, -- fixes CursorHold and CursorHoldl
    { 'nvim-lua/plenary.nvim' }, -- great utility lua functions
    { 'editorconfig/editorconfig-vim' }, -- follow .editorconfig files
    { 'nathom/filetype.nvim' }, -- faster filetype detection
    { 'milisims/nvim-luaref', ft = 'lua' }, -- lua documentation in :help

    -- TODO: define mappings for other prefixes
    -- TODO: https://github.com/folke/which-key.nvim/issues/90
    { 'folke/which-key.nvim' }, -- displays a popup with keybindings

    { 'max397574/better-escape.nvim', event = 'InsertEnter' }, -- better <Esc> with jk
    { 'wellle/targets.vim', event = 'CursorMoved' }, -- provides great new text objects
    { 'andymass/vim-matchup', event = 'CursorHold' }, -- make % smarter
    { 'windwp/nvim-autopairs', event = 'InsertEnter' }, -- auto pairs for {[()]}
    { 'dstein64/vim-startuptime', cmd = 'StartupTime' }, -- startup profiling

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

    { 'chrisbra/NrrwRgn', cmd = { 'NR', 'NUD' } }, -- focus narrow code section
    { 'mizlan/iswap.nvim', cmd = { 'ISwap', 'ISwapWith' } }, -- easily swap function arguments
    { 'tpope/vim-repeat', keys = '.', fn = 'repeat#set' }, -- enables . repeat for plugins

    -- use nvim in the browser
    -- TODO: make this work pls (should work now)
    {
        'glacambre/firenvim',
        run = function()
            vim.fn['firenvim#install'](7)
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
            'if',
            'af',
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
    -- ALTERNATIVE: terrortylor/nvim-comment
    -- TODO: swap for numToStr/Comment.nvim
    -- TODO: https://www.reddit.com/r/neovim/comments/q6lq5o/commentnvim_features_go_brrrrr/hgcxcok/?utm_source=reddit&utm_medium=web2x&context=3
    {
        'tpope/vim-commentary',
        cmd = { 'Comment', 'Commentary' },
        keys = { 'gc', { 'v', 'gc' } },
    },

    -- interactive scratchpad for js/ts and python
    -- DEPENDENCY: tsun
    -- TODO: make this work for typescript
    {
        'metakirby5/codi.vim',
        disable = true,
        cmd = {
            'Codi',
            'Codi!',
            'Codi!!',
        },
    },

    -- fixes <c-a>/<c-x> for dates, negative numbers, markdown headers, etc
    -- ALTERNATIVE: tpope/vim-speeddating
    -- increment sequences with visual block
    -- ALTERNATIVE: triglav/vim-visual-increment
    {
        'monaqa/dial.nvim',
        keys = {
            '<C-a>',
            '<C-x>',
            { 'v', '<C-a>' },
            { 'v', '<C-x>' },
            { 'v', 'g<C-a>' },
            { 'v', 'g<C-x>' },
        },
        after = 'vim-repeat',
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

    -- html super snippets
    -- TODO: https://github.com/pedro757/emmet
    -- TODO: emmet_ls
    -- TODO: https://pbs.twimg.com/media/FC6NKbQWEAA6ZLc?format=jpg&name=4096x4096
    {
        'mattn/emmet-vim',
        ft = {
            'html',
            'vue',
            'javascript.jsx',
            'typescript.tsx',
        },
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

    -- switch between single-line and multiline statement
    -- TODO: lua version?
    {
        'AndrewRadev/splitjoin.vim',
        keys = { 'gS', 'gJ' },
        after = 'vim-easyclip',
    },

    -- 2-char search motion
    {
        'ggandor/lightspeed.nvim',
        keys = { '<C-s>', '<C-S-s>' },
    },

    -- pulse cursorline after search (easier to find the cursor)
    -- TODO: lua version?
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

    -- awesme ascii box drawer
    -- TODO: how to actually use this?
    {
        'gyim/vim-boxdraw',
        disable = true,
        keys = {
            { 'v', '+o' },
            { 'v', '+O' },
            { 'v', '+c' },
            { 'v', '+-' },
            { 'v', '+_' },
            { 'v', '+>' },
            { 'v', '+<' },
            { 'v', '++>' },
            { 'v', '++<' },
            { 'v', '+|' },
            { 'v', '+^' },
            { 'v', '+v' },
            { 'v', '+V' },
            { 'v', '++^' },
            { 'v', '++v' },
            { 'v', '++V' },
            { 'v', '+io' },
            { 'v', '+ao' },
        },
    },

    -- markdown previewer in browser
    -- DEPENDENCY: npm
    {
        'iamcco/markdown-preview.nvim',
        ft = 'markdown',
        run = 'cd app && npm install',
    },

    -- project-wide search and replace
    -- TODO: work on this config
    -- DEPENDENCY: RG, sed
    {
        'windwp/nvim-spectre',
        after = 'plenary.nvim',
        keys = {
            '<Leader>S',
            { 'v', '<Leader>S' },
        },
    },

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
