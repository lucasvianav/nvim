local M = {}

--[[ TODO:
    { LINKS:
        https://www.reddit.com/r/neovim/comments/jvisg5/lets_talk_formatting_again/

        https://www.reddit.com/r/neovim/comments/jvisg5/comment/gjgd6si/?utm_source=reddit&utm_medium=web2x&context=3
        https://www.reddit.com/r/neovim/comments/oxl9pz/comment/h7ndya2/?utm_source=reddit&utm_medium=web2x&context=3
        https://www.reddit.com/r/neovim/comments/mmkzck/comment/gtscils/?utm_source=reddit&utm_medium=web2x&context=3
        https://www.reddit.com/r/neovim/comments/oe7nm1/comment/h44wggh/?utm_source=reddit&utm_medium=web2x&context=3
    }

    { DOTFILES:
        https://github.com/lukas-reineke/dotfiles/tree/master/vim/lua
        https://github.com/lucax88x/configs
        https://github.com/numToStr/dotfiles/tree/master/neovim/.config/nvim
        https://github.com/rockerBOO/dotfiles/blob/current/config/efm-langserver/config.yaml#L197
        https://github.com/rockerBOO/dotfiles/blob/current/config/efm-langserver/config.yaml#L285
        https://github.com/LunarVim/LunarVim/blob/686e54ab0dfa5ffcac37599e5de7984f1d9e738f/lua/lsp/init.lua#L75
        https://github.com/tomaskallup/dotfiles/blob/master/nvim/lua/plugins/nvim-lspconfig.lua#L122
        https://github.com/tomaskallup/dotfiles/blob/master/nvim/lua/efm/prettier.lua
    }
]]--
function M.getAll(use)
    local _use = get_packer_use_wrapper(use, '_packer.plugins.lsp')

    _use({ 'neovim/nvim-lspconfig'   }) -- easier way to config language servers

    _use({ 'kosayoda/nvim-lightbulb', event = 'CursorHold'          }) -- indicates code actions with a lightbulb
    _use({ 'folke/lua-dev.nvim',      ft    = 'lua', as = 'lua-dev' }) -- setup LSP for lua-nvim dev

    -- TODO: get this to work
    _use({ 'ray-x/lsp_signature.nvim', after = 'coq_nvim' }) -- show function signature

    -- easier way to install language servers
    -- TODO: make it work for lua and angular
    _use({ 'kabouzeid/nvim-lspinstall', after = 'nvim-lspconfig' })

    -- code completion with many features
    -- ALTERNATIVE: hrsh7th/nvim-cmp
    -- DEPENDENCY: python3-venv
    _use({ 'ms-jpq/coq_nvim',       branch = 'coq' })
    _use({ 'ms-jpq/coq.artifacts',  branch = 'artifacts', after = 'coq_nvim' }) -- snippets for coq
    _use({ 'ms-jpq/coq.thirdparty', branch = '3p',        after = 'coq_nvim' }) -- additional completion sources for coq

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


