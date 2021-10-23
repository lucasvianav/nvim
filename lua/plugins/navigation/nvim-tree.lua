local function set(property, value)
    vim.g['nvim_tree_' .. property] = value
end

-- dirs/files to be ignored
set('ignore', {
    '.git',
    'node_modules',
    '.cache',
    '__pycache__',
})

-- dirs/files to be highlighted
set('special_files', {
    ['README.md'] = 1,
    ['Makefile'] = 1,
    ['MAKEFILE'] = 1,
})

-- cosmetic
set('indent_markers', false) -- show indentation rulers
set('hide_dotfiles', true) -- hide dirs/files starting with '.'
set('git_hl', false) -- highlight files with git attributtes
set('add_trailing', true) -- append trailing / to dir names
set('group_empty', true) -- compact nested directories with no other files
set('create_in_closed_folder', false) -- cursor is on a closed dir: create new file on the parent

set('show_icons', {
    git = 0,
    folders = 1,
    files = 1,
    folder_arrows = 1,
})

local tree_cb = require('nvim-tree.config').nvim_tree_callback
local keybindings = {
    { key = { '<CR>', 'o', '<2-LeftMouse>', 'l' }, cb = tree_cb('edit') },
    { key = { '<2-RightMouse>', '<C-]>' }, cb = tree_cb('cd') },

    { key = 'v', cb = tree_cb('vsplit') },
    { key = '<C-v>', cb = tree_cb('vsplit') },
    { key = 's', cb = tree_cb('split') },
    { key = '<C-h>', cb = tree_cb('split') },
    { key = '<C-x>', cb = tree_cb('split') },
    { key = 'x', cb = tree_cb('split') },
    { key = 't', cb = tree_cb('tabnew') },
    { key = '<C-t>', cb = tree_cb('tabnew') },
    { key = '<', cb = tree_cb('prev_sibling') },
    { key = '>', cb = tree_cb('next_sibling') },
    { key = 'P', cb = tree_cb('parent_node') },
    { key = 'h', cb = tree_cb('close_node') },
    { key = '<S-CR>', cb = tree_cb('close_node') },
    { key = '<Tab>', cb = tree_cb('preview') },
    { key = 'K', cb = tree_cb('first_sibling') },
    { key = 'J', cb = tree_cb('last_sibling') },
    { key = 'I', cb = tree_cb('toggle_ignored') },
    { key = { 'H', 'zh', 'gh' }, cb = tree_cb('toggle_dotfiles') },
    { key = 'R', cb = tree_cb('refresh') },
    { key = { 'a', 'A' }, cb = tree_cb('create') },
    { key = 'dd', cb = tree_cb('remove') },
    { key = 'r', cb = tree_cb('rename') },
    { key = '<C->', cb = tree_cb('full_rename') },
    { key = 'xx', cb = tree_cb('cut') },
    { key = 'yy', cb = tree_cb('copy') },
    { key = 'p', cb = tree_cb('paste') },
    { key = 'yn', cb = tree_cb('copy_name') },
    { key = { 'yp', 'Y' }, cb = tree_cb('copy_path') },
    { key = { 'ya', 'gy' }, cb = tree_cb('copy_absolute_path') },
    { key = '[c', cb = tree_cb('prev_git_item') },
    { key = '}c', cb = tree_cb('next_git_item') },
    { key = { '-', '<BS>' }, cb = tree_cb('dir_up') },
    { key = 'q', cb = tree_cb('close') },
    { key = '?', cb = tree_cb('toggle_help') },
}

require('nvim-tree').setup({
    disable_netrw = true, -- disables netrw completely
    hijack_netrw = true, -- hijack netrw window on startup
    open_on_setup = false, -- open the tree on setup
    auto_close = true, -- autoclose if it's the last window
    open_on_tab = false, -- opens nvimtree when on a new tab
    hijack_cursor = false, -- keep cursor at filename's start
    update_cwd = false, -- do not change cwd

    -- show diagnostics in the signcol
    diagnostics = {
        enable = true,
        icons = {
            hint    = "",
            info    = "",
            warning = "",
            error   = "",
        }
    },

    -- show focused file on the tree
    update_focused_file = {
        enable = false,
        update_cwd = false, -- update nvimtree cwd to contain the file if the current doesn't
        ignore_list = {}, -- buffernames/filetypes that won't update cwd
    },

    view = {
        width = 30,
        side = 'left',
        auto_resize = false,
        mappings = {
            custom_only = true,
            list = keybindings,
        },
    },
})

map('n', '<Leader>e', '<cmd>lua require("functions").plugins.nvim_tree_toggle()<cr>')
