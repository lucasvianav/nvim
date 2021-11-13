vim.g.firenvim_config = {
    globalSettings = {
        alt = 'all',
    },

    localSettings = {
        ['.*'] = {
            cmdline = 'neovim',
            content = 'text',
            priority = 0,
            selector = 'textarea:not([readonly]), div[role="textbox"]',
            takeover = 'always',
        },
    },
}

-- set filetype to markdown for all GitHub buffers
vim.api.nvim_command('au BufEnter github.com_*.txt set filetype=markdown')

local disable = {
    'https?://w{0,3}twitch.tv/',
    'https?://w{0,3}twitter.com/',
    'https?://w{0,3}web.whatsapp.com/',
}

for _, pattern in ipairs(disable) do
    vim.g.firenvim_config.localSettings[pattern] = {
        takeover = 'never',
        priority = 1,
    }
end
