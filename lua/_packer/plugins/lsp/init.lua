local M = {}

function M.getAll(use)
    local _use = get_packer_use_wrapper(use, '_packer.plugins.lsp')

    _use({ 'neovim/nvim-lspconfig'   }) -- easier way to config language servers

    _use({ 'kosayoda/nvim-lightbulb', event = 'BufRead' }) -- indicates code actions with a lightbulb

    -- code completion with many features
    -- ALTERNATIVE: hrsh7th/nvim-cmp
    -- ALTERNATIVE: onsails/lspkind-nvim
    -- DEPENDENCY: python3-venv
    _use({ 'ms-jpq/coq_nvim', branch = 'coq' })

    -- snippets for coq
    -- ALTERNATIVE: hrsh7th/nvim-vsnip
    _use({ 'ms-jpq/coq.artifacts', branch = 'artifacts', after = 'coq_nvim' })

    -- additional completion sources for coq
    _use({ 'ms-jpq/coq.thirdparty', branch = '3p', after = 'coq_nvim' })

    -- easier way to install language servers
    _use({
        'kabouzeid/nvim-lspinstall',
        after = 'nvim-lspconfig',
    })

    -- pretty windows for lsp lists
    -- ALTERNATIVE: RishabhRD/nvim-lsputils
    _use({
        'folke/trouble.nvim',
        after = { 
            'devicons', 
            'nvim-lspconfig', 
            'nvim-lspinstall' 
        },
        cmd = 'Trouble',
    })
end

return M


