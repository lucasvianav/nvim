require('auto-session').setup({
  enabled = true,
  auto_restore_last_session = false,
  auto_save = true,
  auto_restore = false,
  auto_delete_empty_sessions = true,
  close_unsupported_windows = true,
  args_allow_files_auto_save = false,
  continue_restore_on_error = false,
  allowed_dirs = nil,
  log_level = 'error',

  -- close unwanted windows before saving
  pre_save_cmds = { 'silent! tabdo NvimTreeClose' },

  -- fix Neovim height after start (so cmdheight isn't huge) (#64) (#11330)
  post_restore_cmds = { 'silent !kill -s SIGWINCH $PPID' },

  -- TODO: maybe swap for allowed dirs
  suppressed_dirs = require('v.utils.wrappers').expand_in_list({
    '/',
    '/home',
    '~',
    '~/Desktop',
    '~/Documents',
    '~/Downloads',
    '~/Pictures',
  }),

  bypass_save_filetypes = {
    '',
    'NvimTree',
    'NvimTree_*',
    'dashboard',
    'gitcommit',
    'help',
    'lsp-installer',
    'packer',
    'packer',
    'startify',
    'terminal',
    'text',
  },
})
