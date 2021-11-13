local M = {
    -- start screen
    {
        'glepnir/dashboard-nvim',
        cmd = {
            'Dashboard',
            'DashboardNewFile',
        },
    },

    -- seamless navigation between neovim widows and tmux panes
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
        as = 'quickscope',
        keys = { 'f', 'F', 't', 'T' },
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
            -- markdown header picker
            { 'crispgm/telescope-heading.nvim' },

            -- C sorter
            { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },

            -- github and octo integration
            -- { 'nvim-telescope/telescope-github.nvim' },
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
