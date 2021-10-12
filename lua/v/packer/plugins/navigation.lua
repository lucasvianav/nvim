local M = {}

function M.getAll(use)
    local _use = require('functions').wrappers.get_packer_use_wrapper(use, 'navigation')

    -- start screen
    -- @ALTERNATIVE: mhinz/vim-startify
    _use({
        'glepnir/dashboard-nvim',
        cmd = { 'Dashboard', 'DashboardNewFile' },
    })

    -- navigate seamlessly between vim widows and tmux panes
    _use({
        'numToStr/Navigator.nvim',
        keys = { '<C-h>', '<C-j>', '<C-k>', '<C-l>' },
    })

    -- NERDTree-like file explorer
    _use({
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
    })

    -- ranger file explorer
    _use({
        'kevinhwang91/rnvimr',
        as = 'ranger',
        cmd = 'RnvimrToggle',
        keys = '<Leader>r',
    })

    -- highlight f/F and t/T targets
    _use({
        'unblevable/quick-scope',
        as = 'quickscope',
        keys = { 'f', 'F', 't', 'T' },
    }, {
        setup = true,
    })

    -- run commands in tmux pane from nvim
    _use({
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
    })

    -- fuzzy finder
    -- @ALTERNATIVE: junegunn/fzf.vim
    _use({
        'nvim-telescope/telescope.nvim',
        after = 'plenary.nvim',
        requires = {
            -- emoji picker
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

            -- better sorting (firefox-like)
            -- { 'nvim-telescope/telescope-frecency.nvim' },

            -- github and octo integration
            -- { 'nvim-telescope/telescope-github.nvim' },

            -- info about plugins, etc
            -- { 'sudormrfbin/cheatsheet.nvim' },
        },
    })

    -- auto-session picker for telescope
    _use({
        'rmagatti/session-lens',
        after = {
            'telescope.nvim',
            'auto-session',
        },
    })
end

return M
