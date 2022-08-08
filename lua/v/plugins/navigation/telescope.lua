local actions = require('telescope.actions')
local telescope = require('telescope')
local utils = require('v.utils.telescope')
local builtin = require('telescope.builtin')

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
      '%.eot',
      '%.svg',
      '%.woff2',
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
      file_ignore_patterns = {
        '^.git',
        '**/.git',
        '^.git/',
        '**/.git/',
        '^.git/*',
        '**/.git/*',
        '^./.git',
      },
    },

    live_grep = {
      glob_pattern = '!package-lock.json',
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

    git_branches = utils.pickers.center_dropdown,
    diagnostics = utils.pickers.center_dropdown,
  },
})

telescope.load_extension('fzf')

require('v.utils.mappings').set_keybindings({
  -- general
  { 'n', '<Leader>ff', builtin.find_files },
  { 'n', '<Leader>fr', builtin.resume },
  { 'n', '<Leader>fp', builtin.live_grep },
  { 'n', '<Leader>fb', builtin.buffers },
  { 'n', '<Leader>fc', builtin.commands },
  { 'n', '<Leader>fch', builtin.command_history },
  { 'n', '<Leader>fj', builtin.jumplist },
  { 'n', 'z=', builtin.spell_suggest },

  -- lsp
  { 'n', 'gd', builtin.lsp_definitions },
  { 'n', 'gr', builtin.lsp_references },
  { 'n', 'gi', builtin.lsp_implementations },
  {
    'n',
    '<Leader>fg',
    function()
      builtin.diagnostics({ bufnr = 0 })
    end,
  },
  { 'n', '<Leader>fgw', builtin.diagnostics },

  -- git
  { 'n', '<Leader>gb', builtin.git_branches },
  { 'n', '<Leader>gc', builtin.git_commits },

  -- extensions
  { 'n', '<Leader>fh', telescope.extensions.heading.heading },
  {
    'n',
    '<Leader>fs',
    [[<cmd>lua require('telescope').extensions['session-lens'].search_session()<cr>]],
  },

  -- custom functions
  { 'n', '<leader>fn', utils.find_nvim },
  { 'n', '<leader>fk', utils.find_in_plugins },
  { 'n', '<leader>fd', utils.find_dotfiles },
  { 'n', '<leader>f/', utils.grep_last_search },
  { 'n', '<leader>fu', utils.find_unimed },
  { 'n', '<leader>fw', utils.find_work },
  { 'n', '<leader>fpu', utils.grep_unimed },

  -- code actions
  {
    'n',
    '<Leader>ca',
    function()
      vim.lsp.buf.code_action()
    end,
  },
  {
    'v',
    '<Leader>ca',
    function()
      vim.lsp.buf.range_code_action()
    end,
  },
})
