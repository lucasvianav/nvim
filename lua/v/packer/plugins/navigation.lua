local M = {
    -- start screen
    {
        'glepnir/dashboard-nvim',
        cmd = {
            'Dashboard',
            'DashboardNewFile',
        },
    },

    -- seamless navigation between
    -- neovim widows and tmux panes
    {
        'numToStr/Navigator.nvim',
        keys = {
            '<C-h>',
            '<C-j>',
            '<C-k>',
            '<C-l>',
        },
    },

    -- nerdtree-like file explorer
    {
        'kyazdani42/nvim-tree.lua',
        as = 'nvim-tree',
        after = 'devicons',
        cmd = {
            'NvimTreeToggle',
            'NvimTreeFindFile',
            'NvimTreeClose',
        },
        keys = '<Leader>e',
        fn = { 'nvim_tree_toggle' },
    },

    -- ranger file explorer
    {
        'kevinhwang91/rnvimr',
        as = 'ranger',
        cmd = 'RnvimrToggle',
        keys = '<Leader>r',
    },

    -- highlight f/F and t/T targets
    {
        'unblevable/quick-scope',
        as     = 'quickscope',
        keys   = { 'f', 'F', 't', 'T' },
        __opts = { setup = true },
    },

    -- run commands in tmux pane from neovim
    {
        'preservim/vimux',
        cmd = {
            'VimuxPromptCommand',
            'VimuxRunLastCommand',
            'VimuxInspectRunner',
            'VimuxZoomRunner',
            'VimuxClearScreenHistory',
            'VimuxTogglePane',
        },
        keys = {
            '<Leader>tp',
            '<Leader>tr',
            '<Leader>ti',
            '<Leader>tz',
            '<Leader>tc',
            '<Leader>tt',
        },
    },

    -- fuzzy finder for lots of stuff
    {
        'nvim-telescope/telescope.nvim',
        after = 'plenary.nvim',
        requires = {
            -- emoji picker
            -- TODO: maybe remove this because Kitty already has one
            {
                'xiyaowong/telescope-emoji.nvim',
                config = function()
                    require('plugins/navigation/emoji')
                end,
            },

            -- markdown header picker
            { 'crispgm/telescope-heading.nvim' },

            -- C implementation
            { 'nvim-telescope/telescope-fzy-native.nvim' },

            -- TODO: activate below extensions

            -- better sorting (firefox-like)
            -- { 'nvim-telescope/telescope-frecency.nvim' },

            -- github and octo integration
            -- { 'nvim-telescope/telescope-github.nvim' },

            -- info about plugins, etc
            -- { 'sudormrfbin/cheatsheet.nvim' },

            -- tldr pages
            -- { 'mrjones2014/tldr.nvim' },
        },
    },

    -- auto-session picker for telescope
    -- TODO: move this inside telescope table?
    {
        'rmagatti/session-lens',
        after = {
            'telescope.nvim',
            'auto-session',
        },
    },
}

return M
