local keybindings = {
  { key = { 'v', '<C-v>' },    action = 'vsplit' },
  { key = { 's', '<C-x>' },    action = 'split' },
  { key = { 't', '<C-t>' },    action = 'tabnew' },
  { key = { '<CR>', 'l' },     action = 'edit' },
  { key = 'h',                 action = 'close_node' },
  { key = '<Tab>',             action = 'preview' },
  { key = 'P',                 action = 'parent_node' },
  { key = 'K',                 action = 'first_sibling' },
  { key = 'J',                 action = 'last_sibling' },
  { key = 'I',                 action = 'toggle_ignored' },
  { key = { 'H', 'zh', 'gh' }, action = 'toggle_dotfiles' },
  { key = 'R',                 action = 'refresh' },
  { key = { 'a', 'A' },        action = 'create' },
  { key = 'dd',                action = 'remove' },
  { key = 'r',                 action = 'rename' },
  { key = '<C-r>',             action = 'full_rename' },
  { key = 'xx',                action = 'cut' },
  { key = 'yy',                action = 'copy' },
  { key = 'p',                 action = 'paste' },
  { key = 'yn',                action = 'copy_name' },
  { key = { 'yp', 'Y' },       action = 'copy_path' },
  { key = { 'ya', 'gy' },      action = 'copy_absolute_path' },
  { key = ']c',                action = 'prev_git_item' },
  { key = '[c',                action = 'next_git_item' },
  { key = '<BS>',              action = 'dir_up' },
  { key = 'q',                 action = 'close' },
  { key = '?',                 action = 'toggle_help' },
  { key = 'cd',                action = 'cd' },
}

local on_attach = function(bufnr)
  local api = require('nvim-tree.api')
  local desc = function(description)
    return {
      desc = 'nvim-tree: ' .. description,
    }
  end

  require('v.utils.mappings').set_keybindings({
    { 'n', { 'v', '<C-v>' }, api.node.open.vertical, desc("Open: Vertical Split")},
    { 'n', { 's', '<C-x>' }, api.node.open.horizontal, desc("Open: Horizontal Split") },
    { 'n', { 't', '<C-t>' }, api.node.open.tab, desc("Open: New Tab") },
    { 'n', { '<CR>', 'l' }, api.node.open.edit, desc("Open") },
    { 'n', 'h', api.node.navigate.parent_close, desc("Close Directory")},
    { 'n', '<Tab>', api.node.open.preview, desc("Open Preview") },
    { 'n', 'P', api.node.navigate.parent, desc("Parent Directory") },
    { 'n', 'K', api.node.navigate.sibling.first, desc("First Sibling") },
    { 'n', 'J', api.node.navigate.sibling.last, desc("Last Sibling") },
    { 'n', 'I', api.tree.toggle_gitignore_filter, desc("Toggle Filter: Git Ignore") },
    { 'n', { 'H', 'zh', 'gh' }, api.tree.toggle_hidden_filter, desc("Toggle Filter: Dotfiles") },
    { 'n', 'R', api.tree.reload, desc("Refresh") },
    { 'n', { 'a', 'A' }, api.fs.create, desc("Create File Or Directory") },
    { 'n', 'dd', api.fs.remove, desc("Delete") },
    { 'n', 'r', api.fs.rename, desc("Rename") },
    { 'n', '<C-r>', api.fs.rename_full, desc("Rename: Full Path") },
    { 'n', 'xx', api.fs.cut, desc("Cut") },
    { 'n', 'yy', api.fs.copy.node, desc("Copy") },
    { 'n', 'p', api.fs.paste, desc("Paste") },
    { 'n', 'yn', api.fs.copy.filename, desc("Copy Name") },
    { 'n', { 'yp', 'Y' }, api.fs.copy.relative_path, desc("Copy Relative Path") },
    { 'n', { 'ya', 'gy' }, api.fs.copy.absolute_path, desc("Copy Absolute Path") },
    { 'n', ']c', api.node.navigate.git.prev, desc("Prev Git") },
    { 'n', '[c', api.node.navigate.git.next, desc("Next Git") },
    { 'n', '<BS>', api.tree.change_root_to_parent, desc("Up") },
    { 'n', 'q', api.tree.close, desc("Close") },
    { 'n', '?', api.tree.toggle_help, desc("Help") },
    { 'n', 'cd', api.tree.change_root_to_node, desc("CD") },
  }, {
      buffer = bufnr,
      noremap = true,
  })
end

require('nvim-tree').setup({
  disable_netrw = false,           -- disables netrw completely
  hijack_netrw = true,             -- hijack netrw window on startup
  open_on_tab = false,             -- opens nvimtree when on a new tab
  hijack_cursor = false,           -- keep cursor at filename's start
  update_cwd = true,               -- update cwd on `DirChanged`
  create_in_closed_folder = false, -- cursor is on a closed dir: create new file on the parent

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
    adaptive_size = true,
    width = '13%',
    side = 'left',
  },

  renderer = {
    group_empty = true,          -- compact empty nested directories
    add_trailing = true,         -- trailing `/` to dir names
    highlight_git = true,        -- highlight files with git attributtes
    highlight_opened_files = 'all',
    root_folder_modifier = ':t', -- tail cwd

    indent_markers = {
      enable = true,
    },
    icons = {
      git_placement = 'after',
      show = {
        git = true,
        folder = true,
        file = true,
        folder_arrow = true,
      },
      glyphs = {
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
    },
    special_files = {
      'MAKEFILE',
      'Makefile',
      'README.md',
      '.gitignore',
      'package.json',
    },
  },

  filters = {
    dotfiles = false, -- don't hide .files

    -- dirs/files to be ignored
    custom = {
      '^\\.git$',
      '^node_modules$',
      '^\\.cache$',
      '^__pycache__$',
      '^.DS_Store$',
      '^package-lock\\.json$',
    },
  },
  on_attach = on_attach,
})

require('v.utils.mappings').map('n', '<Leader>e', require('v.utils.tree').nvim_tree_toggle)

local colors = require('v.utils').colors
local hl_utils = require('v.utils.highlights')
local alter_color = hl_utils.alter_color

hl_utils.set_highlights({
  {
    'NvimTreeRootFolder',
    {
      bold = true,
      italic = true,
      fg = colors.off_white,
    },
  },
  { 'Directory', { bold = true } },
  {
    'NvimTreeGitDirty',
    { fg = alter_color(colors.blue_light, -10) },
  },
  {
    'NvimTreeOpenedFolderName',
    {
      bold = true,
      italic = true,
      fg = alter_color(colors.yellow, -10),
    },
  },
})
