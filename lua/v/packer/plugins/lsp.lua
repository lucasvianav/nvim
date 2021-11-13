-- ok so there's not only lsp stuff in here
-- there's all kind of completion-related plugins

local M = {
    { 'neovim/nvim-lspconfig' }, -- config for language servers

    { 'folke/lua-dev.nvim', ft = 'lua', as = 'lua-dev' }, -- setup LSP for lua-nvim dev
    { 'kosayoda/nvim-lightbulb', event = 'CursorHold' }, -- indicates code actions
    { 'SirVer/ultisnips', event = 'InsertEnter' }, -- cool snippet engine

    --[[
        -- nice code actions
        {
            'weilbith/nvim-code-action-menu',
            key = '<leader>ca',
        },
    ]]

    -- not actually LSP-related but what the heck
    -- DEPENDENCY: universal-ctags, ctags
    -- TODO: solve VimLeave errors and setup keybindings
    {
        'ludovicchabant/vim-gutentags',
        requires = 'skywind3000/gutentags_plus',
    },

    -- TODO: get this to work
    -- show function signature
    {
        'ray-x/lsp_signature.nvim',
        disable = true,
        after = 'coq_nvim',
    },

    -- easier way to install language servers
    {
        'williamboman/nvim-lsp-installer',
        after = 'nvim-lspconfig',
    },

    --[[
        -- code completion and snippets
        -- DEPENDENCY: python3-venv
        { 'ms-jpq/coq_nvim', branch = 'coq' },
        { 'ms-jpq/coq.artifacts', branch = 'artifacts', after = 'coq_nvim' }, -- snippets
        { 'ms-jpq/coq.thirdparty', branch = '3p', after = 'coq_nvim' }, -- completion sources
    ]]

    {
        'hrsh7th/nvim-cmp',
        requires = {
            { 'f3fora/cmp-spell', after = 'nvim-cmp' },
            { 'hrsh7th/cmp-buffer', after = 'nvim-cmp' },
            { 'hrsh7th/cmp-cmdline', after = 'nvim-cmp' },
            { 'hrsh7th/cmp-nvim-lsp', after = 'nvim-cmp' },
            { 'hrsh7th/cmp-nvim-lsp-document-symbol', after = 'nvim-cmp' },
            { 'hrsh7th/cmp-nvim-lua', after = 'nvim-cmp' },
            { 'hrsh7th/cmp-path', after = 'nvim-cmp' },
            { 'lukas-reineke/cmp-under-comparator', after = 'nvim-cmp' },
            { 'onsails/lspkind-nvim', after = 'nvim-cmp' },
            { 'ray-x/cmp-treesitter', after = 'nvim-cmp' },
        },
        event = { 'InsertEnter', 'CmdLineEnter' },
    },

    -- pretty list for lsp
    {
        'folke/trouble.nvim',
        after = {
            'devicons',
            'nvim-lspconfig',
            'nvim-lspinstall',
        },
        cmd = 'Trouble',
        disable = true,
    },

    -- html super snippets
    -- TODO: https://github.com/pedro757/emmet
    -- TODO: emmet_ls
    -- TODO: https://pbs.twimg.com/media/FC6NKbQWEAA6ZLc?format=jpg&name=4096x4096
    {
        'mattn/emmet-vim',
        ft = {
            'html',
            'vue',
            'javascript.jsx',
            'typescript.tsx',
        },
    },
}

return M
