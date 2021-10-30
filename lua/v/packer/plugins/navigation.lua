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
    -- TODO: make issue about limiting scroll options?
    -- TODO: https://www.reddit.com/r/neovim/comments/p8wtmn/telescopenvim_how_to_take_what_i_selected_in/
    -- https://www.reddit.com/r/neovim/comments/phndpv/can_telescope_remember_my_last_search_result/
    {
        'nvim-telescope/telescope.nvim',
        after = 'plenary.nvim',
        requires = {
            -- markdown header picker
            { 'crispgm/telescope-heading.nvim' },

            -- C implementation
            { 'nvim-telescope/telescope-fzy-native.nvim' },

            -- TODO: activate extensions below

            -- better sorting (firefox-like)
            -- { 'nvim-telescope/telescope-frecency.nvim' },

            -- github and octo integration
            -- { 'nvim-telescope/telescope-github.nvim' },

            -- info about plugins, etc
            -- { 'sudormrfbin/cheatsheet.nvim' },

            -- tldr pages
            -- { 'mrjones2014/tldr.nvim' },

            -- https://github.com/AckslD/nvim-neoclip.lua
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