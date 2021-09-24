local cmd = vim.cmd

vim.g.firenvim_config = {
    globalSettings = {
        alt = 'all',
    },

    localSettings = {
        ['.*'] = {
            cmdline  = 'neovim',
            content  = 'text',
            priority = 0,
            selector = 'textarea:not([readonly]), div[role="textbox"]',
            takeover = 'once',
        },
    },
}

-- set filetype to markdown for all GitHub buffers
cmd([[au BufEnter github.com_*.txt set filetype=markdown]])

local function disable(pattern)
    vim.g.firenvim_config['localSettings'][pattern] = {
        'takeover': 'never',
        'priority': 1,
    }
end


disable('https?://twitter.com/')
disable('https?://twitch.tv/')
disable('https?://web.whatsapp.com/')
