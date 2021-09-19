local o = vim.opt
local cmd = vim.cmd
local fn = vim.fn

-- list of desired treesitter parsers
local parsers = {
    'bash', 'bibtex', 'c', 'comment', 'css', 'dockerfile',
    'graphql', 'html', 'javascript', 'jsdoc', 'tsx', 'vim',
    'jsonc', 'json', 'lua', 'python', 'scss', 'typescript', 
    'yaml',
}

-- install all desired parsrs
-- for _, parser in pairs(parsers) do cmd(':TSInstall ' .. parser) end

-- setup treesitter for better syntax
-- configs (highlighting, indentation, etc)
require('nvim-treesitter.configs').setup({
    ensure_installed = parsers,

    highlight = { enable = true },
    rainbow   = { enable = true, extended_mode = true },
    -- autotag   = { enable = true },
})

-- use for folding
-- o.foldmethod = 'expr'
-- o.foldexpr   = fn['nvim_treesitter#foldexpr']()

