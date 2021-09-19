local M = {}

function M.getAll(use)
    local _use = get_packer_use_wrapper(use, '_packer.plugins.syntax')

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

    -- autoclose html tags
    -- ALTERNATIVE: windwp/nvim-ts-autotag
    _use({
        'alvan/vim-closetag',
        ft = {
            'html', 'vue',
            'javascript.jsx',
            'typescript.tsx',
        },
    })

    -- autoedit matching html tags
    -- ALTERNATIVE: windwp/nvim-ts-autotag
    _use({
        'valloric/MatchTagAlways',
        ft = {
            'html', 'vue',
            'javascript.jsx',
            'typescript.tsx',
        },
    })

    -- autoedit enclosing html tags
    _use({
        'AndrewRadev/tagalong.vim',
        ft = {
            'html', 'vue',
            'javascript.jsx',
            'typescript.tsx',
        },
    })
end

return M

