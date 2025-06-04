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

local ibl = require("ibl")
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
      "nofile",
      "prompt",
      "terminal",
      "lspinfo",
      "checkhealth",
      "help",
      "man",
      "lazy",
    },
    filetypes = {
      "NvimTree",
      "NvimTree_*",
      "dashboard",
      "gitcommit",
      "help",
      "lsp-installer",
      "markdown",
      "nofile",
      "oil",
      "lazy",
      "prompt",
      "quickfix",
      "sql",
      "startify",
      "terminal",
    },
  },
})

hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_space_indent_level)
