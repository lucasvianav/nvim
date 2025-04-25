-- show_foldtext = false,
-- context_patterns = {
--   'class',
--   'function',
--   'method',
--   'block',
--   'list_literal',
--   'selector',
--   '^if',
--   '^table',
--   'if_statement',
--   'while',
--   'for',
-- },

local ibl = require('ibl')
local hooks = ibl.hooks

ibl.setup({
  whitespace = {
    remove_blankline_trail = true,
  },
  scope = {
    enabled = true,
    show_start = true,
    show_end = false,
  },
  exclude = {
    buftypes = {
      'nofile',
      'prompt',
      'terminal',
      'lspinfo',
      'packer',
      'checkhealth',
      'help',
      'man',
    },
    filetypes = {
      'NvimTree',
      'NvimTree_*',
      'dashboard',
      'gitcommit',
      'help',
      'lsp-installer',
      'markdown',
      'packer',
      'packer',
      'sql',
      'startify',
      'terminal',
      'nofile',
      'quickfix',
      'prompt',
    },
  },
})

hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_space_indent_level)
