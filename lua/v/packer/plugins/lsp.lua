-- TODO: https://www.reddit.com/r/neovim/comments/px1hnf/popup_menu_for_code_actions_to_show/
-- https://github.com/weilbith/nvim-code-action-menu
-- TODO: https://github.com/lspcontainers/lspcontainers.nvim
-- TODO: https://www.reddit.com/r/neovim/comments/q9g6e7/which_one_do_you_like_better_for_completion/hgxp01w/
-- TODO: https://elijahmanor.com/blog/neovim-tailwindcss

local M = {
    { 'neovim/nvim-lspconfig' }, -- config for language servers

    { 'folke/lua-dev.nvim', ft = 'lua', as = 'lua-dev' }, -- setup LSP for lua-nvim dev
    { 'kosayoda/nvim-lightbulb', event = 'CursorHold' }, -- indicates code actions
    { 'SirVer/ultisnips', event = 'InsertEnter' }, -- cool snippet engine

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
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-cmdline',
            'lukas-reineke/cmp-under-comparator',
            'hrsh7th/cmp-nvim-lua',
            'ray-x/cmp-treesitter',
            'onsails/lspkind-nvim',
        },
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
}

return M
