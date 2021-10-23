-- TODO: https://github.com/akinsho/dotfiles/blob/main/.config/nvim/lua/as/plugins/telescope.lua
-- https://github.com/danielnehrig/nvim/blob/master/lua/telescope/_extensions/dotfiles.lua
-- https://github.com/danielnehrig/nvim/blob/master/lua/plugins/telescope/init.lua

local actions   = require('telescope.actions')
local telescope = require('telescope')

telescope.setup({
    defaults = {
        prompt_prefix = '   ',
        selection_caret = ' > ',
        entry_prefix = '   ',
        initial_mode = 'insert',
        file_sorter = require('telescope.sorters').get_fuzzy_file,
        file_ignore_patterns = {},
        generic_sorter = require('telescope.sorters').get_generic_fuzzy_sorter,
        set_env = { ['COLORTERM'] = 'truecolor' },
        color_devicons = true,

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
                ['q'] = actions.close,
                ['v'] = actions.file_vsplit,
                ['s'] = actions.file_split,
            },
        },
    },

    pickers = {
    },

    extensions = {
        lsp_handlers = {
            code_action = {
                telescope = require('telescope.themes').get_dropdown({}),
            },
        },
    },
})

telescope.load_extension('heading')

require('v.utils.mappings').set_keybindings({
    -- general
    { 'n', '<Leader>ff', [[:<C-U>lua require('telescope.builtin').find_files()<cr>]] },
    { 'n', '<Leader>fr', [[:<C-U>lua require('telescope.builtin').oldfiles()<cr>]] },
    { 'n', '<Leader>fp', [[:<C-U>lua require('telescope.builtin').live_grep()<cr>]] },
    { 'n', '<Leader>fb', [[:<C-U>lua require('telescope.builtin').buffers()<cr>]] },
    { 'n', '<Leader>fc', [[:<C-U>lua require('telescope.builtin').commands()<cr>]] },
    { 'n', '<Leader>fch', [[:<C-U>lua require('telescope.builtin').command_history()<cr>]] },
    { 'n', '<Leader>fj', [[:<C-U>lua require('telescope.builtin').jumplist()<cr>]] },
    { 'n', '<Leader>f/', [[:<C-U>lua require('telescope.builtin').current_buffer_fuzzy_find()<cr>]] },

    -- lsp
    { 'n', 'gd', [[:<C-U>lua require('telescope.builtin').lsp_definitions()<cr>]] },
    { 'n', 'gr', [[:<C-U>lua require('telescope.builtin').lsp_references()<cr>]] },
    { 'n', 'gi', [[:<C-U>lua require('telescope.builtin').lsp_implementations()<cr>]] },
    {
        'n',
        '<Leader>ca',
        [[:<C-U>lua require('telescope.builtin').lsp_code_actions(require('telescope.themes').get_dropdown({}))<cr>]],
    },
    { 'v', '<Leader>ca', [[:<C-U>lua require('telescope.builtin').lsp_range_code_actions()<cr>]] },
    { 'n', '<Leader>fg', [[:<C-U>lua require('telescope.builtin').lsp_document_diagnostics()<cr>]] },
    { 'n', '<Leader>fgw', [[:<C-U>lua require('telescope.builtin').lsp_workspace_diagnostics()<cr>]] },

    -- git
    { 'n', '<Leader>gc', [[:<C-U>lua require('telescope.builtin').git_commits()<cr>]] },
    { 'n', '<Leader>gs', [[:<C-U>lua require('telescope.builtin').git_status()<cr>]] },

    -- extensions
    { 'n', '<Leader>fh', [[:<C-U>lua require('telescope').extensions.heading.heading()<cr>]] },
    { 'n', '<Leader>fs', [[:<C-U>lua require('telescope').extensions['session-lens'].search_session()<cr>]] },
})

local map = require('v.utils.mappings').map

-- TODO: fix these functions and move them to utils
function _G.find_unimed()
    require('telescope.builtin').find_files({
        shorten_path = false,
        cwd = vim.fn.expand('$WORK_DIR') .. '/unimed-pj',
        prompt = '~ unimed ~',
    })
end

function _G.grep_unimed()
    require('telescope.builtin').live_grep({
        shorten_path = false,
        cwd = vim.fn.expand('$WORK_DIR') .. '/unimed-pj',
        prompt = '~ unimed ~',
    })
end

map('n', '<leader>fu', '<cmd>lua find_unimed()<cr>')
map('n', '<leader>fpu', '<cmd>lua grep_unimed()<cr>')
