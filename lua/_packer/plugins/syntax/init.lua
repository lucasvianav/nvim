local M = {}

function M.getAll(use)
    local _use = get_packer_use_wrapper(use, '_packer.plugins.languages')

    _use({ 'lervag/vimtex', ft = { 'tex',  'plaintex'       } }) -- LaTeX
    _use({ 'elzr/vim-json', ft = { 'json', 'jsonc', 'jsonp' } }) -- JSON

    -- treesitter (code parsing for syntax highlighting, etc)
    _use({
        'nvim-treesitter/nvim-treesitter',
        event = 'BufRead', run = ':TSUpdate',
    })

    -- betters commentstrings based in treesitter
    _use({
        'JoosepAlviste/nvim-ts-context-commentstring',
        as = 'context-commentstring',
        after = { 'vim-commentary', 'nvim-treesitter' },
        cmd = 'CommentToggle', keys = 'gc',
    })

    -- prettier
    -- DEPENDENCY: npm (yarn?)
    _use({
        'prettier/vim-prettier',
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
end

return M


