local function set (property, value)
    vim.g['nvim_tree_' .. property] = value
end

set('ignore',     {})   -- dirs/files to be ignored
set('auto_close', true) -- autoclose if it's the last window

set('disable_netrw', true) -- ranger will be used for it instead
set('hijack_netrw',  true) -- ranger will be used for it instead

-- cosmetic
set('hijack_cursor',   false)     -- don't keep cursor at filename's start
set('indent_markers',  false)     -- show indentation rulers
set('hide_dotfiles',   true)      -- hide dirs/files starting with '.'
set('git_hl',          false)     -- highlight files with git attributtes
set('add_trailing',    true)      -- append trailing / to dir names
set('group_empty',     true)      -- compact nested directories with no other files
set('lsp_diagnostics', false)     -- show lsp diagnostics on the signcol

set('show_icons', {
    git = 0,
    folders = 1,
    files = 1,
    folder_arrows = 1,
})

-- keybindings
local tree_cb = require('nvim-tree.config').nvim_tree_callback
set('disable_default_keybindings', true)
set('bindings', {
    { key = { "<CR>", "o", "<2-LeftMouse>", "l" }, cb = tree_cb("edit") },
    { key = { "<2-RightMouse>", "<C-]>" }, cb = tree_cb("cd") },
    { key = "v", cb = tree_cb("vsplit") },
    { key = "s", cb = tree_cb("split") },
    { key = "t", cb = tree_cb("tabnew") },
    { key = "<", cb = tree_cb("prev_sibling") },
    { key = ">", cb = tree_cb("next_sibling") },
    { key = "P", cb = tree_cb("parent_node") },
    { key = "h", cb = tree_cb("close_node") },
    { key = "<S-CR>", cb = tree_cb("close_node") },
    { key = "<Tab>", cb = tree_cb("preview") },
    { key = "K", cb = tree_cb("first_sibling") },
    { key = "J", cb = tree_cb("last_sibling") },
    { key = "I", cb = tree_cb("toggle_ignored") },
    { key = { "H", "zh", "gh" }, cb = tree_cb("toggle_dotfiles") },
    { key = "R", cb = tree_cb("refresh") },
    { key = { "a", "A" }, cb = tree_cb("create") },
    { key = "dd", cb = tree_cb("remove") },
    { key = "r", cb = tree_cb("rename") },
    { key = "<C->", cb = tree_cb("full_rename") },
    { key = "xx", cb = tree_cb("cut") },
    { key = "yy", cb = tree_cb("copy") },
    { key = "p", cb = tree_cb("paste") },
    { key = "yn", cb = tree_cb("copy_name") },
    { key = { "yp", "Y" }, cb = tree_cb("copy_path") },
    { key = { "ya", "gy" }, cb = tree_cb("copy_absolute_path") },
    { key = "[c", cb = tree_cb("prev_git_item") },
    { key = "}c", cb = tree_cb("next_git_item") },
    { key = { "-", "<BS>" }, cb = tree_cb("dir_up") },
    { key = "q", cb = tree_cb("close") },
    { key = "?", cb = tree_cb("toggle_help") },
})

map('n', '<Leader>e', ':<C-U>NvimTreeToggle<CR>')

