local M = {}

--[[ TODO:
    { PLUGINS:
        https://github.com/jose-elias-alvarez/null-ls.nvim
        https://github.com/sbdchd/neoformat
        https://github.com/mattn/efm-langserver
        https://github.com/mhartington/formatter.nvim
        https://github.com/lukas-reineke/format.nvim
    }

    { REDDIT:
        https://www.reddit.com/r/neovim/comments/l6bbrd/can_anyone_give_a_simple_step_by_step_guide_to/
        https://www.reddit.com/user/Maskdask/comments/ocj6y9/do_you_use_builtin_lsp_for_autoformatting/
        https://www.reddit.com/r/neovim/comments/oxl9pz/whats_the_recommended_way_to_handle_formatting/
        https://www.reddit.com/r/neovim/comments/oc8riy/out_of_the_box_lint_and_format_settings/
        https://www.reddit.com/r/neovim/comments/o1d88e/which_autoformatting_plugin_do_you_recommend/
        https://www.reddit.com/r/neovim/comments/mmkzck/losing_my_mind_with_formatting/
        https://www.reddit.com/r/neovim/comments/le1duu/nvim_lsp_and_typescript_eslint_and_prettier/
        https://www.reddit.com/r/neovim/comments/oe7nm1/how_to_add_linting_into_lua_based_config_with/
        https://www.reddit.com/user/Maskdask/comments/ocj6y9/do_you_use_builtin_lsp_for_autoformatting/
        https://www.reddit.com/r/neovim/comments/oc8riy/out_of_the_box_lint_and_format_settings/
    }

    { LSPCONFIG:
        https://github.com/neovim/nvim-lspconfig/wiki/User-contributed-tips#diagnosticls
        https://github.com/neovim/nvim-lspconfig/wiki/User-contributed-tips#efm
    }
]]--
function M.getAll(use)
    local _use = get_packer_use_wrapper(use, '_packer.plugins.lsp')

    _use({ 'neovim/nvim-lspconfig'   }) -- easier way to config language servers

    _use({ 'kosayoda/nvim-lightbulb',  event = 'CursorHold' }) -- indicates code actions with a lightbulb

    -- TODO: get this to work
    _use({ 'ray-x/lsp_signature.nvim', after = 'coq_nvim'    }) -- show function signature

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
    -- TODO: make it work for lua and angular
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


