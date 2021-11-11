local M = {
    { 'itchyny/vim-highlighturl' }, -- highlight urls

    { 'lervag/vimtex', ft = { 'tex', 'plaintex' } }, -- LaTeX
    { 'fladson/vim-kitty', ft = { 'kitty' } }, -- kitty config
    { 'tpope/vim-sleuth', event = 'CursorHold' }, -- autodetect indent
    { 'dkarter/bullets.vim', ft = 'markdown' }, -- markdown lists
    { 'vuki656/package-info.nvim', ft = 'json' }, -- package.json

    { 'jose-elias-alvarez/nvim-lsp-ts-utils', ft = 'typescript' }, -- TypeScript utilities
    { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }, -- code parsing for syntax highlighting, etc

    -- JSON
    -- TODO: can this work with treesitter and LSP?
    -- TODO: also this https://github.com/akinsho/dotfiles/blob/main/.config/nvim/after/syntax/markdown.vim
    {
        'elzr/vim-json',
        disable = true,
        ft = {
            'json',
            'jsonc',
            'jsonp',
        },
    },

    -- better commentstrings based in treesitter
    {
        'JoosepAlviste/nvim-ts-context-commentstring',
        as = 'context-commentstring',
        after = { 'vim-commentary', 'nvim-treesitter' },
    },

    -- prettier
    -- TODO: what is the use of this?
    -- DEPENDENCY: npm (yarn?)
    {
        'prettier/vim-prettier',
        disable = true,
        ft = {
            'javascript',
            'typescript',
            'javascript.jsx',
            'typescript.tsx',
            'vue',
            'graphql',
            'html',
            'css',
            'scss',
            'json',
            'markdown',
            'yaml',
        },
        cmd = {
            'Prettier',
            'PrettierAsync',
            'PrettierPartial',
            'PrettierFragment',
        },
        run = 'npm install', -- TODO: must be yarn?
    },

    -- autoclose and autoedit html tags
    {
        'windwp/nvim-ts-autotag',
        ft = {
            'html',
            'vue',
            'javascript.jsx',
            'javascriptreact',
            'typescript.tsx',
            'typescriptreact',
        },
    },

    -- fix `gf` for some filetypes
    {
        'tpope/vim-apathy',
        ft = {
            'go',
            'javascript',
            'typescript',
            'lua',
            'python',
            'c',
            'cpp',
        },
    },
}

return M
