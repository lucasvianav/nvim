local ascii = require('utils').ascii
local g     = vim.g
local fn    = vim.fn
local cmd   = vim.cmd

g.dashboard_disable_at_vimenter = 1 -- dashboard is disabled by default
g.dashboard_disable_statusline  = 1
g.dashboard_default_executive   = "telescope"


g.dashboard_custom_header = ascii.hydra

g.dashboard_custom_section = {
    a = { description = { "  Find File                 SPC f f" }, command = "Telescope find_files" },
    b = { description = { "  Recents                   SPC f r" }, command = "Telescope oldfiles" },
    c = { description = { "  Grep                      SPC f g" }, command = "Telescope live_grep" },
    -- d = { description = { "洛 New File                  SPC n  " }, command = "DashboardNewFile" },
    -- e = { description = { "  Bookmarks                 SPC b m" }, command = "Telescope marks" },
    -- f = { description = { "  Load Last Session         SPC l  " }, command = "SessionLoad" },
}

g.dashboard_custom_footer = {
    "   ",
}

-- disables tabline for dashboard
cmd('autocmd FileType dashboard set showtabline=0 | autocmd WinLeave <buffer> set showtabline=2')

