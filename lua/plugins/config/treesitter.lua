local cmd = vim.cmd

-- list of desired treesitter parsers
local parsers = {
    'bash', 'bibtex', 'c', 'comment', 'css', 'dockerfile',
    'graphql', 'html', 'javascript', 'jsdoc', 'tsx', 'vim',
    'JSON with comments', 'json', 'lua', 'python', 'scss',
    'typescript', 'yaml',
}

-- install all desired parsrs
for parser in pairs(parsers) do cmd(':TSInstall ' .. parser) end

-- setup treesitter for better syntax
-- configs (highlighting, indentation, etc)
require('nvim-treesitter.configs').setup({
    ensure_installed = 'maintained',
    highlight = { enable = true },
    autopairs = { enable = true },
})

