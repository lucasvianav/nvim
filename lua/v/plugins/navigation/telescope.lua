local actions = require('telescope.actions')
local telescope = require('telescope')
local utils = require('v.utils.telescope')

telescope.setup({
    defaults = {
        prompt_prefix = '   ',
        selection_caret = '  ',
        entry_prefix = '   ',
        initial_mode = 'insert',
        color_devicons = true,

        set_env = { ['COLORTERM'] = 'truecolor' },
        path_display = { 'absolute' },

        file_ignore_patterns = {
            '%.jpg',
            '%.jpeg',
            '%.png',
            '%.otf',
            '%.ttf',
        },

        mappings = {
            i = {
                ['<C-k>'] = actions.move_selection_previous,
                ['<C-j>'] = actions.move_selection_next,
                ['<Esc>'] = actions.close,
                ['<C-v>'] = actions.file_vsplit,
                ['<C-h>'] = actions.file_split,
                ['<C-s>'] = actions.file_split,
                ['<C-y>'] = actions.toggle_selection,
                ['<C-a>'] = actions.select_all,
                ['<M-q>'] = actions.smart_add_to_qflist + actions.open_qflist,
                ['<M-C-Q>'] = actions.smart_send_to_qflist + actions.open_qflist,
                ['<TAB>'] = actions.toggle_selection + actions.move_selection_next,
                ['<S-TAB>'] = actions.toggle_selection + actions.move_selection_previous,
            },

            n = {
                ['<C-k>'] = actions.move_selection_previous,
                ['<C-j>'] = actions.move_selection_next,
                ['<C-c>'] = actions.close,
                ['q'] = actions.close,
                ['v'] = actions.file_vsplit,
                ['s'] = actions.file_split,
                ['<C-y>'] = actions.toggle_selection,
                ['<C-a>'] = actions.select_all,
                ['<M-q>'] = actions.smart_add_to_qflist + actions.open_qflist,
                ['<M-C-Q>'] = actions.smart_send_to_qflist + actions.open_qflist,
                ['<TAB>'] = actions.toggle_selection + actions.move_selection_next,
                ['<S-TAB>'] = actions.toggle_selection + actions.move_selection_previous,
            },
        },
    },

    pickers = {
        find_files = {
            follow = true,
            hidden = true,
            file_ignore_patterns = { '.git', '.git/', '.git/*' },
        },

        git_commits = {
            previewer = false,
            theme = 'dropdown',

            mappings = {
                i = {
                    ['<CR>'] = utils.open_in_diff,
                    ['<c-o>'] = utils.open_in_diff,
                },

                n = {
                    ['<CR>'] = utils.open_in_diff,
                },
            },
        },

        buffers = {
            ignore_current_buffer = true,
            sort_lastused = true,
            show_all_buffers = true,
            previewer = false,
            theme = 'dropdown',

            mappings = {
                i = {
                    ['<M-C-S-H>'] = actions.delete_buffer,
                },

                n = {
                    ['dd'] = actions.delete_buffer,
                },
            },
        },

        git_branches = {
            theme = 'dropdown',
            previewer = false,
            layout_strategy = 'center',
        },

        lsp_code_actions = {
            theme = 'cursor',
            promppt_tile = 'Code Actions',
        },

        lsp_range_code_actions = {
            theme = 'cursor',
            promppt_tile = 'Code Actions',
        },
    },
})

telescope.load_extension('fzf')

require('v.utils.mappings').set_keybindings({
    -- general
    { 'n', '<Leader>ff', [[:<C-U>lua require('telescope.builtin').find_files()<cr>]] },
    { 'n', '<Leader>fr', [[:<C-U>lua require('telescope.builtin').resume()<cr>]] },
    { 'n', '<Leader>fp', [[:<C-U>lua require('telescope.builtin').live_grep()<cr>]] },
    { 'n', '<Leader>fb', [[:<C-U>lua require('telescope.builtin').buffers()<cr>]] },
    { 'n', '<Leader>fc', [[:<C-U>lua require('telescope.builtin').commands()<cr>]] },
    { 'n', '<Leader>fch', [[:<C-U>lua require('telescope.builtin').command_history()<cr>]] },
    { 'n', '<Leader>fj', [[:<C-U>lua require('telescope.builtin').jumplist()<cr>]] },

    -- lsp
    { 'n', 'gd', [[:<C-U>lua require('telescope.builtin').lsp_definitions()<cr>]] },
    { 'n', 'gr', [[:<C-U>lua require('telescope.builtin').lsp_references()<cr>]] },
    { 'n', 'gi', [[:<C-U>lua require('telescope.builtin').lsp_implementations()<cr>]] },
    {
        'n',
        '<Leader>ca',
        [[:<C-U>lua require('telescope.builtin').lsp_code_actions()<cr>]],
    },
    { 'v', '<Leader>ca', [[:<C-U>lua require('telescope.builtin').lsp_range_code_actions()<cr>]] },
    {
        'n',
        '<Leader>fg',
        [[:<C-U>lua require('telescope.builtin').lsp_document_diagnostics()<cr>]],
    },
    {
        'n',
        '<Leader>fgw',
        [[:<C-U>lua require('telescope.builtin').lsp_workspace_diagnostics()<cr>]],
    },

    -- git
    { 'n', '<Leader>gb', [[:<C-U>lua require('telescope.builtin').git_branches()<cr>]] },
    { 'n', '<Leader>gc', [[:<C-U>lua require('telescope.builtin').git_commits()<cr>]] },

    -- extensions
    { 'n', '<Leader>fh', [[:<C-U>lua require('telescope').extensions.heading.heading()<cr>]] },
    {
        'n',
        '<Leader>fs',
        [[:<C-U>lua require('telescope').extensions['session-lens'].search_session()<cr>]],
    },

    -- custom functions
    { 'n', '<leader>fu', '<cmd>lua require("v.utils.telescope").find_unimed()<cr>' },
    { 'n', '<leader>fpu', '<cmd>lua require("v.utils.telescope").grep_unimed()<cr>' },
    { 'n', '<leader>fn', '<cmd>lua require("v.utils.telescope").find_nvim()<cr>' },
    { 'n', '<leader>fd', '<cmd>lua require("v.utils.telescope").find_dotfiles()<cr>' },
    { 'n', '<leader>f/', '<cmd>lua require("v.utils.telescope").grep_last_search()<cr>' },
})
