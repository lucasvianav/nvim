-- TODO: write function to diff between current branch and another one
-- maybe get name from input? origin's default branch?

local cb = require('diffview.config').diffview_callback

require('diffview').setup({
  diff_binaries = false,
  enhanced_diff_hl = false,
  use_icons = true,

  signs = {
    fold_closed = '',
    fold_open = '',
  },

  file_panel = {
    win_config = {
      position = 'left',
      width = 35,
    },
    listing_style = 'tree',
    tree_options = {
      flatten_dirs = true,
      folder_statuses = 'always', -- 'never', 'only_folded' or 'always'.
    },
  },

  file_history_panel = {
    win_config = {
      position = 'bottom',
      height = 16,
    },
    log_options = {
      max_count = 256, -- Limit the number of commits
      follow = false, -- Follow renames (only for single file)
      all = false, -- Include all refs under 'refs/' including HEAD
      merges = false, -- List only merge commits
      no_merges = false, -- List no merge commits
      reverse = false, -- List commits in reverse order
    },
  },

  key_bindings = {
    disable_defaults = true,

    view = {
      ['<tab>'] = cb('select_next_entry'),
      ['<s-tab>'] = cb('select_prev_entry'),
      ['gf'] = cb('goto_file'),
      ['<C-w><C-f>'] = cb('goto_file_split'),
      ['<C-w>f'] = cb('goto_file_split'),
      ['<C-w>gf'] = cb('goto_file_tab'),
      ['<leader>e'] = cb('focus_files'),
      ['<leader>b'] = cb('toggle_files'),
    },

    file_panel = {
      ['j'] = cb('next_entry'),
      ['k'] = cb('prev_entry'),
      ['<cr>'] = cb('select_entry'),
      ['l'] = cb('select_entry'),
      ['<2-LeftMouse>'] = cb('select_entry'),
      ['-'] = cb('toggle_stage_entry'),
      ['s'] = cb('toggle_stage_entry'),
      ['S'] = cb('stage_all'),
      ['U'] = cb('unstage_all'),
      ['X'] = cb('restore_entry'),
      ['R'] = cb('refresh_files'),
      ['<tab>'] = cb('select_next_entry'),
      ['<s-tab>'] = cb('select_prev_entry'),
      ['gf'] = cb('goto_file'),
      ['<C-w><C-f>'] = cb('goto_file_split'),
      ['<C-w>f'] = cb('goto_file_split'),
      ['<C-w>gf'] = cb('goto_file_tab'),
      ['i'] = cb('listing_style'), -- toggle between 'list' and 'tree' views
      ['f'] = cb('toggle_flatten_dirs'),
      ['<leader>e'] = cb('focus_files'),
      ['<leader>b'] = cb('toggle_files'),
    },

    file_history_panel = {
      ['g!'] = cb('options'),
      ['<C-A-d>'] = cb('open_in_diffview'),
      ['y'] = cb('copy_hash'),
      ['zR'] = cb('open_all_folds'),
      ['zM'] = cb('close_all_folds'),
      ['j'] = cb('next_entry'),
      ['k'] = cb('prev_entry'),
      ['<cr>'] = cb('select_entry'),
      ['l'] = cb('select_entry'),
      ['<2-LeftMouse>'] = cb('select_entry'),
      ['<tab>'] = cb('select_next_entry'),
      ['<s-tab>'] = cb('select_prev_entry'),
      ['gf'] = cb('goto_file'),
      ['<C-w><C-f>'] = cb('goto_file_split'),
      ['<C-w>f'] = cb('goto_file_split'),
      ['<C-w>gf'] = cb('goto_file_tab'),
      ['<leader>e'] = cb('focus_files'),
      ['<leader>b'] = cb('toggle_files'),
    },

    option_panel = {
      ['<tab>'] = cb('select'),
      ['q'] = cb('close'),
    },
  },
})
