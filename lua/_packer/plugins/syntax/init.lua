local M = {}

--[[ TODO:
    Darazaki/indent-o-matic
    tpope/vim-sleuth
    editorconfig/editorconfig-vim
]]--
function M.getAll(use)
    local _use = get_packer_use_wrapper(use, '_packer.plugins.syntax')

    _use({ 'dkarter/bullets.vim', ft = 'markdown' }) -- Markdown

    _use({ 'lervag/vimtex', ft = { 'tex',  'plaintex'       } }) -- LaTeX
    _use({ 'elzr/vim-json', ft = { 'json', 'jsonc', 'jsonp' } }) -- JSON

    -- code parsing for syntax highlighting, etc
    _use({ 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' })

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
            'javascript', 'typescript',
            'javascript.jsx', 'typescript.tsx',
            'vue', 'graphql', 'html', 'css',
            'scss', 'json', 'markdown', 'yaml',
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
            'html', 'vue',
            'javascript.jsx',
            'javascriptreact',
            'typescript.tsx',
            'typescriptreact',
        },
    })
end

return M

