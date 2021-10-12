local M = {}

function M.getAll(use)
    local _use = require('functions').wrappers.get_packer_use_wrapper(use, 'syntax')

    _use({ 'lervag/vimtex', ft = { 'tex', 'plaintex' } }) -- LaTeX
    _use({ 'fladson/vim-kitty', ft = { 'kitty' } }) -- Kitty config
    _use({ 'tpope/vim-sleuth', event = 'CursorHold' })

    -- JSON
    -- TODO: can this work with treesitter and LSP?
    -- TODO: also this https://github.com/akinsho/dotfiles/blob/main/.config/nvim/after/syntax/markdown.vim
    _use({
        'elzr/vim-json',
        disable = true,
        ft = {
            'json',
            'jsonc',
            'jsonp',
        },
    })

    _use({ 'dkarter/bullets.vim', ft = 'markdown' }) -- Markdown
    _use({ 'jose-elias-alvarez/nvim-lsp-ts-utils', ft = 'typescript' }) -- TypeScript
    _use({ 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }) -- code parsing for syntax highlighting, etc

    -- betters commentstrings based in treesitter
    _use({
        'JoosepAlviste/nvim-ts-context-commentstring',
        as = 'context-commentstring',
        after = { 'vim-commentary', 'nvim-treesitter' },
    })

    -- prettier
    -- DEPENDENCY: npm (yarn?)
    _use({
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
    })

    -- autoclose and autoedit html tags
    _use({
        'windwp/nvim-ts-autotag',
        ft = {
            'html',
            'vue',
            'javascript.jsx',
            'javascriptreact',
            'typescript.tsx',
            'typescriptreact',
        },
    })
end

return M
