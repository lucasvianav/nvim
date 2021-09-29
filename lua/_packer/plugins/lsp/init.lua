local M = {}

function M.getAll(use)
    local _use = get_packer_use_wrapper(use, '_packer.plugins.lsp')

    -- TODO: https://www.reddit.com/r/neovim/comments/px1hnf/popup_menu_for_code_actions_to_show/
    -- https://github.com/weilbith/nvim-code-action-menu

    _use({ 'neovim/nvim-lspconfig' }) -- easier way to config language servers
    _use({ 'kosayoda/nvim-lightbulb', event = 'CursorHold' }) -- indicates code actions with a lightbulb

    -- not actually LSP-related but what the heck
    -- DEPENDENCY: universal-ctags, ctags
    _use({
        'ludovicchabant/vim-gutentags',
        requires = 'skywind3000/gutentags_plus',
    })

    -- TODO: go through issues and make this work!!!
    _use({ 'folke/lua-dev.nvim', ft = 'lua', as = 'lua-dev' }) -- setup LSP for lua-nvim dev

    -- TODO: get this to work
    -- show function signature
    _use({
        'ray-x/lsp_signature.nvim',
        disable = true,
        after = 'coq_nvim',
    })

    -- easier way to install language servers
    -- TODO: make it work for lua and angular
    -- lua works for files outside of my config (????). worked when editing
    -- remote file from github (rockerBOO's config)
    -- TODO: make an issue to lua-dev. maybe folke can helpe me?
    -- TODO: actually setup angular https://github.com/kabouzeid/nvim-lspinstall/issues/72#issuecomment-927527670
    _use({
        'nvim-lspinstall',
        after = 'nvim-lspconfig',
    }, {
        dev = true,
        fallback = 'kabouzeid/nvim-lspinstall',
    })

    -- code completion with many features
    -- TODO: try cmp?????
    -- TODO: make issue about completion quality?
    -- ALTERNATIVE: hrsh7th/nvim-cmp
    -- DEPENDENCY: python3-venv
    _use({ 'ms-jpq/coq_nvim', branch = 'coq' })
    _use({ 'ms-jpq/coq.artifacts', branch = 'artifacts', after = 'coq_nvim' }) -- snippets for coq
    _use({ 'ms-jpq/coq.thirdparty', branch = '3p', after = 'coq_nvim' }) -- additional completion sources for coq

    -- pretty windows for lsp lists
    -- ALTERNATIVE: RishabhRD/nvim-lsputils
    _use({
        'folke/trouble.nvim',
        after = {
            'devicons',
            'nvim-lspconfig',
            'nvim-lspinstall',
        },
        cmd = 'Trouble',
        disable = true,
    })
end

return M
