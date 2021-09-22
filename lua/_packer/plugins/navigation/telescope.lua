local actions   = require('telescope.actions')
local telescope = require('telescope')

telescope.setup({
    defaults = {
        prompt_prefix        = "   ",
        selection_caret      = " > ",
        entry_prefix         = "   ",
        initial_mode         = "insert",
        file_sorter          = require('telescope.sorters').get_fuzzy_file,
        file_ignore_patterns = {},
        generic_sorter       = require('telescope.sorters').get_generic_fuzzy_sorter,
        set_env              = { ['COLORTERM'] = 'truecolor' },

        mappings = {
            i = {
                ['<C-k>'] = actions.move_selection_previous,
                ['<C-j>'] = actions.move_selection_next,
                ['<Esc>'] = actions.close,
                ['<C-v>'] = actions.file_vsplit,
                ['<C-h>'] = actions.file_split,
                ['<C-s>'] = actions.file_split,
            },

            n = {
                ['<C-k>'] = actions.move_selection_previous,
                ['<C-j>'] = actions.move_selection_next,
                ['<C-c>'] = actions.close,
                ['q']     = actions.close,
                ['v']     = actions.file_vsplit,
                ['s']     = actions.file_split,
            },
        },
    },

    extensions = {
        lsp_handlers = {
            code_action = {
                telescope = require('telescope.themes').get_dropdown({}),
            },
        },


    }
})

telescope.load_extension('heading')
telescope.load_extension('emoji')

-- general
map('n', '<Leader>ff',  [[:<C-U>lua require('telescope.builtin').find_files()<cr>]])
map('n', '<Leader>fr',  [[:<C-U>lua require('telescope.builtin').oldfiles()<cr>]])
map('n', '<Leader>fp',  [[:<C-U>lua require('telescope.builtin').live_grep()<cr>]])
map('n', '<Leader>fb',  [[:<C-U>lua require('telescope.builtin').buffers()<cr>]])
map('n', '<Leader>fc',  [[:<C-U>lua require('telescope.builtin').commands()<cr>]])
map('n', '<Leader>fch', [[:<C-U>lua require('telescope.builtin').command_history()<cr>]])
map('n', '<Leader>fj',  [[:<C-U>lua require('telescope.builtin').jumplist()<cr>]])
map('n', '<Leader>f/',  [[:<C-U>lua require('telescope.builtin').current_buffer_fuzzy_find()<cr>]])

-- lsp
map('n', 'gd',         [[:<C-U>lua require('telescope.builtin').lsp_definitions()<cr>]])
map('n', 'gr',         [[:<C-U>lua require('telescope.builtin').lsp_references()<cr>]])
map('n', 'gi',         [[:<C-U>lua require('telescope.builtin').lsp_implementations()<cr>]])
map('n', '<Leader>ca', [[:<C-U>lua require('telescope.builtin').lsp_code_actions(require('telescope.themes').get_dropdown({}))<cr>]])
map('v', '<Leader>ca', [[:<C-U>lua require('telescope.builtin').lsp_range_code_actions()<cr>]])
map('n', '<Leader>fg', [[:<C-U>lua require('telescope.builtin').lsp_document_diagnostics()<cr>]])
map('n', '<Leader>fgw', [[:<C-U>lua require('telescope.builtin').lsp_workspace_diagnostics()<cr>]])

-- git
map('n', '<Leader>gc', [[:<C-U>lua require('telescope.builtin').git_commits()<cr>]])
map('n', '<Leader>gs', [[:<C-U>lua require('telescope.builtin').git_status()<cr>]])

-- extensions
map('n', '<Leader>fe', [[:<C-U>lua require('telescope').extensions.emoji.emoji()<cr>]])
map('n', '<Leader>fh', [[:<C-U>lua require('telescope').extensions.heading.heading()<cr>]])
map('n', '<Leader>fs', [[:<C-U>lua require('telescope').extensions['session-lens'].search_session()<cr>]])

