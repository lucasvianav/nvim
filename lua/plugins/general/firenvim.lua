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
            takeover = 'always',
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


disable('https?://w{0,3}twitter.com/')
disable('https?://w{0,3}twitch.tv/')
disable('https?://w{0,3}web.whatsapp.com/')
