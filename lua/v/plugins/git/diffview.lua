local actions = require('diffview.actions')

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
      single_files = {
        max_count = 256, -- Limit the number of commits
        follow = true, -- Follow renames (only for single file)
        all = false, -- Include all refs under 'refs/' including HEAD
        merges = false, -- List only merge commits
        no_merges = true, -- List no merge commits
        reverse = false, -- List commits in reverse order
      },
      multi_files = {
        max_count = 256,
        follow = false,
        all = false,
        merges = false,
        no_merges = true,
        reverse = false,
      },
    },
  },

  key_bindings = {
    disable_defaults = true,

    view = {
      ['<tab>'] = actions.select_next_entry,
      ['<s-tab>'] = actions.select_prev_entry,
      ['gf'] = actions.goto_file,
      ['<C-w><C-f>'] = actions.goto_file_split,
      ['<C-w>f'] = actions.goto_file_split,
      ['<C-w>gf'] = actions.goto_file_tab,
      ['<leader>e'] = actions.focus_files,
      ['<leader>b'] = actions.toggle_files,
    },

    file_panel = {
      ['j'] = actions.next_entry,
      ['k'] = actions.prev_entry,
      ['<cr>'] = actions.select_entry,
      ['l'] = actions.select_entry,
      ['<2-LeftMouse>'] = actions.select_entry,
      ['-'] = actions.toggle_stage_entry,
      ['s'] = actions.toggle_stage_entry,
      ['S'] = actions.stage_all,
      ['U'] = actions.unstage_all,
      ['X'] = actions.restore_entry,
      ['R'] = actions.refresh_files,
      ['<tab>'] = actions.select_next_entry,
      ['<s-tab>'] = actions.select_prev_entry,
      ['gf'] = actions.goto_file,
      ['<C-w><C-f>'] = actions.goto_file_split,
      ['<C-w>f'] = actions.goto_file_split,
      ['<C-w>gf'] = actions.goto_file_tab,
      ['i'] = actions.listing_style, -- toggle between 'list' and 'tree' views
      ['f'] = actions.toggle_flatten_dirs,
      ['<leader>e'] = actions.focus_files,
      ['<leader>b'] = actions.toggle_files,
    },

    file_history_panel = {
      ['g!'] = actions.options,
      ['<C-A-d>'] = actions.open_in_diffview,
      ['y'] = actions.copy_hash,
      ['zR'] = actions.open_all_folds,
      ['zM'] = actions.close_all_folds,
      ['j'] = actions.next_entry,
      ['k'] = actions.prev_entry,
      ['<cr>'] = actions.select_entry,
      ['l'] = actions.select_entry,
      ['<2-LeftMouse>'] = actions.select_entry,
      ['<tab>'] = actions.select_next_entry,
      ['<s-tab>'] = actions.select_prev_entry,
      ['gf'] = actions.goto_file,
      ['<C-w><C-f>'] = actions.goto_file_split,
      ['<C-w>f'] = actions.goto_file_split,
      ['<C-w>gf'] = actions.goto_file_tab,
      ['<leader>e'] = actions.focus_files,
      ['<leader>b'] = actions.toggle_files,
    },

    option_panel = {
      ['<tab>'] = actions.select_entry,
      ['q'] = actions.close,
    },
  },
})
