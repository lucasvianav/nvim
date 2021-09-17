local M = {}

function M.getAll(use)
    local _use = get_packer_use_wrapper(use, '_packer.plugins.navigation')

    -- start screen
    -- @ALTERNATIVE: mhinz/vim-startify
    _use({
        "glepnir/dashboard-nvim",
        cmd = { "Dashboard", "DashboardNewFile", },
    })

    -- navigate seamlessly between vim widows and tmux panes
    _use({
        'numToStr/Navigator.nvim',
        keys = { '<C-h>', '<C-j>', '<C-k>', '<C-l>' },
    })

    -- NERDTree-like file explorer
    _use ({
        'kyazdani42/nvim-tree.lua', as = 'nvim-tree',
        requires = 'kyazdani42/nvim-web-devicons',
        after = 'devicons',
        cmd = 'NvimTreeToggle',
        keys = '<Leader>e',
    })

    -- ranger file explorer
    _use({
        'kevinhwang91/rnvimr', as = 'ranger',
        cmd = 'RnvimrToggle', keys = '<Leader>r',
    }) 

    -- highlight f/F and t/T targets
    _use({
        'unblevable/quick-scope', as = 'quickscope',
        keys = { 'f', 'F', 't', 'T' }, 
    }, true)

    -- run commands in tmux pane from nvim
    _use({
        'preservim/vimux',
        cmd = {
            'VimuxPromptCommand', 'VimuxRunLastCommand',
            'VimuxInspectRunner', 'VimuxZoomRunner',
            'VimuxClearScreenHistory', 'VimuxTogglePane',
        },
        keys = {
            '<Leader>tp', '<Leader>tr', '<Leader>ti',
            '<Leader>tz', '<Leader>tc', '<Leader>tt',
        },
    })

    -- fuzzy finder
    -- @ALTERNATIVE: junegunn/fzf.vim
    _use({
        "nvim-telescope/telescope.nvim",
        requires = { 
            { 'nvim-lua/plenary.nvim' }, 

            -- emoji picker
            {
                'xiyaowong/telescope-emoji.nvim',
                config = function()
                    require('_packer/plugins/navigation/emoji')
                end
            }, 

            {  'crispgm/telescope-heading.nvim' }, -- markdown header picker
        } 
    })

    -- auto-session picker for telescope
    _use({
        'rmagatti/session-lens',
        disable = true,
        after = {
            'telescope.nvim',
            'auto-session',
        },
    })
end

return M


