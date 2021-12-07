require('v.utils').set_viml_options('nvim_tree', {
    -- dirs/files to be highlighted
    special_files = {
        ['README.md'] = 1,
        ['Makefile'] = 1,
        ['MAKEFILE'] = 1,
    },

    -- cosmetic
    indent_markers = true, -- show indentation rulers
    git_hl = true, -- highlight files with git attributtes
    add_trailing = true, -- trailing `/` to dir names
    group_empty = true, -- compact empty nested directories
    create_in_closed_folder = false, -- cursor is on a closed dir: create new file on the parent
    root_folder_modifier = ':t', -- tail cwd
    highlight_opened_files = true,

    icons = {
        default = '',
        git = {
            unstaged = '',
            staged = '',
            unmerged = '',
            renamed = '',
            untracked = '',
            deleted = '',
        },
    },

    show_icons = {
        git = 1,
        folders = 1,
        files = 1,
        folder_arrows = 1,
    },
})

local cb = require('nvim-tree.config').nvim_tree_callback
local keybindings = {
    { key = { '<CR>', 'o', '<2-LeftMouse>', 'l' }, cb = cb('edit') },
    { key = { '<2-RightMouse>', '<C-]>' }, cb = cb('cd') },

    { key = 'v', cb = cb('vsplit') },
    { key = '<C-v>', cb = cb('vsplit') },
    { key = 's', cb = cb('split') },
    { key = '<C-h>', cb = cb('split') },
    { key = '<C-x>', cb = cb('split') },
    { key = 'x', cb = cb('split') },
    { key = 't', cb = cb('tabnew') },
    { key = '<C-t>', cb = cb('tabnew') },
    { key = '<', cb = cb('prev_sibling') },
    { key = '>', cb = cb('next_sibling') },
    { key = 'P', cb = cb('parent_node') },
    { key = 'h', cb = cb('close_node') },
    { key = '<S-CR>', cb = cb('close_node') },
    { key = '<Tab>', cb = cb('preview') },
    { key = 'K', cb = cb('first_sibling') },
    { key = 'J', cb = cb('last_sibling') },
    { key = 'I', cb = cb('toggle_ignored') },
    { key = { 'H', 'zh', 'gh' }, cb = cb('toggle_dotfiles') },
    { key = 'R', cb = cb('refresh') },
    { key = { 'a', 'A' }, cb = cb('create') },
    { key = 'dd', cb = cb('remove') },
    { key = 'r', cb = cb('rename') },
    { key = '<C->', cb = cb('full_rename') },
    { key = 'xx', cb = cb('cut') },
    { key = 'yy', cb = cb('copy') },
    { key = 'p', cb = cb('paste') },
    { key = 'yn', cb = cb('copy_name') },
    { key = { 'yp', 'Y' }, cb = cb('copy_path') },
    { key = { 'ya', 'gy' }, cb = cb('copy_absolute_path') },
    { key = '[c', cb = cb('prev_git_item') },
    { key = '}c', cb = cb('next_git_item') },
    { key = { '-', '<BS>' }, cb = cb('dir_up') },
    { key = 'q', cb = cb('close') },
    { key = '?', cb = cb('toggle_help') },
    { key = 'cd', cb = cb('cd') },
}

require('nvim-tree').setup({
    disable_netrw = true, -- disables netrw completely
    hijack_netrw = true, -- hijack netrw window on startup
    open_on_setup = false, -- open the tree on setup
    auto_close = true, -- autoclose if it's the last window
    open_on_tab = false, -- opens nvimtree when on a new tab
    hijack_cursor = false, -- keep cursor at filename's start
    update_cwd = true, -- update cwd on `DirChanged`

    -- show diagnostics in the signcol
    diagnostics = {
        enable = true,
        icons = {
            hint = '',
            info = '',
            warning = '',
            error = '',
        },
    },

    -- show focused file on the tree
    update_focused_file = {
        enable = false,
        update_cwd = false, -- update cwd to contain the file if it doesn't
        ignore_list = {},
    },

    view = {
        width = '20%',
        auto_resize = true,
        side = 'left',
        mappings = {
            custom_only = true,
            list = keybindings,
        },
    },

    filters = {
        dotfiles = false, -- don't hide .files

        -- dirs/files to be ignored
        custom = {
            '.git',
            'node_modules',
            '.cache',
            '__pycache__',
            '.DS_Store',
            'package-lock.json',
        },
    },
})

local toggle_cmd = '<cmd>lua require("v.utils.tree").nvim_tree_toggle()<cr>'
require('v.utils.mappings').map('n', '<Leader>e', toggle_cmd)

local colors = require('v.utils').colors
local hl_utils = require('v.utils.highlights')
local alter_color = hl_utils.alter_color

hl_utils.set_highlights({
    {
        'NvimTreeRootFolder',
        {
            gui = { 'bold', 'italic' },
            guifg = colors.off_white,
        },
    },
    { 'Directory', { gui = 'bold' } },
    {
        'NvimTreeGitDirty',
        { guifg = alter_color(colors.blue_light, -10) },
    },
    {
        'NvimTreeOpenedFolderName',
        {
            gui = { 'bold', 'italic' },
            guifg = alter_color(colors.yellow, -10),
        },
    },
})
