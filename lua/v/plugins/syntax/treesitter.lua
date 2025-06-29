-- TODO: https://github.com/akinsho/dotfiles/blob/main/.config/nvim/lua/as/plugins/treesitter.lua
-- https://github.com/nvim-treesitter/nvim-treesitter/commit/d78fb79ed6f3e5260db48f352d8dcbd3e82935a3
-- TODO: https://www.reddit.com/r/neovim/comments/v3npcv/highlighting_graphql_template_strings_in_jsts/
-- TODO: https://github.com/nvim-treesitter/nvim-treesitter-context

-- TODO: how to have embedded languages in custom methods
-- for example have require("v.utils.autocmds").augroup have the same highlighting
-- as vim.api.nvim_create_autocmd (maybe https://www.youtube.com/watch?v=v3o9YaHBM4Q)

-- READ: https://www.masteringemacs.org/article/tree-sitter-complications-of-parsing-languages

local parser_configs = require("nvim-treesitter.parsers").get_parser_configs()
parser_configs.qf = { ---@diagnostic disable-line: inject-field
  install_info = {
    url = "https://github.com/OXY2DEV/tree-sitter-qf",
    files = { "src/parser.c" },
    branch = "main",
  },
}
parser_configs.lua_patterns = { ---@diagnostic disable-line: inject-field
  install_info = {
    url = "https://github.com/OXY2DEV/tree-sitter-lua_patterns",
    files = { "src/parser.c" },
    branch = "main",
  },
}

-- list of desired treesitter parsers
local parsers = {
  "angular",
  "bash",
  "bibtex",
  "c",
  "comment",
  "cpp",
  "css",
  "dockerfile",
  "elixir",
  "graphql",
  "haskell",
  "html",
  "javascript",
  "jsdoc",
  "json",
  "jsonc",
  "kotlin",
  "latex",
  "lua",
  "lua_patterns",
  "markdown",
  "markdown_inline",
  "prisma",
  "proto",
  "python",
  "qf",
  "scss",
  "tsx",
  "typescript",
  "vim",
  "yaml",
}

local treesitter = require("nvim-treesitter.configs")
local enable = { enable = true }
local disable = { enable = false }

treesitter.setup({
  ensure_installed = parsers,
  autopairs = enable,
  autotag = enable,
  indent = disable,
  matchup = {
    enable = true,
    include_match_words = true,
  },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  rainbow = {
    enable = true,
    extended_mode = true,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<m-v>",
      node_incremental = "<tab>",
      node_decremental = "<s-tab>",
    },
  },
})

local indent_on = function()
  treesitter.setup({ indent = { enable = true } })
end

local indent_off = function()
  treesitter.setup({ indent = { enable = true } })
end

-- use treesitter indent module only for React files
require("v.utils.autocmds").augroup("ReactIndentTS", {
  { event = "BufEnter", opts = { pattern = { "*.tsx", "*.jsx" }, callback = indent_on } },
  { event = "BufLeave", opts = { pattern = { "*.tsx", "*.jsx" }, callback = indent_off } },
})

vim.treesitter.language.register("markdown", "vimwiki")
