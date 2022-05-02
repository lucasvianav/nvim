-- TODO: https://github.com/akinsho/dotfiles/blob/main/.config/nvim/lua/as/plugins/treesitter.lua
-- https://github.com/nvim-treesitter/nvim-treesitter/commit/d78fb79ed6f3e5260db48f352d8dcbd3e82935a3

-- READ: https://www.masteringemacs.org/article/tree-sitter-complications-of-parsing-languages

-- list of desired treesitter parsers
local parsers = {
  'bash',
  'bibtex',
  'c',
  'comment',
  'cpp',
  'css',
  'dockerfile',
  'graphql',
  'html',
  'javascript',
  'jsdoc',
  'json',
  'jsonc',
  'lua',
  'markdown',
  'python',
  'scss',
  'tsx',
  'typescript',
  'vim',
  'yaml',
}

local treesitter = require('nvim-treesitter.configs')
local enable = { enable = true }
local disable = { enable = false }

treesitter.setup({
  ensure_installed = parsers,

  autopairs = enable,
  autotag = enable,
  indent = disable,
  matchup = enable,

  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },

  context_commentstring = {
    enable = true,
    enable_autocmd = false,
  },

  rainbow = {
    enable = true,
    extended_mode = true,
  },
})

local indent_on = function()
  treesitter.setup({ indent = { enable = true } })
end

local indent_off = function()
  treesitter.setup({ indent = { enable = true } })
end

-- use treesitter indent module only for React files
require('v.utils.autocmds').augroup('ReactIndentTS', {
  { event = 'BufEnter', opts = { pattern = { '*.tsx', '*.jsx' }, callback = indent_on } },
  { event = 'BufLeave', opts = { pattern = { '*.tsx', '*.jsx' }, callback = indent_off } },
})
