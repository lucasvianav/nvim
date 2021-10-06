local function set(property, value)
    vim.g['mkdp_' .. property] = value
end

set('auto_start', false)
set('auto_close', false)
set('refresh_slow', true)
set('open_to_the_world', false)
set('browser', 'brave-browser')

vim.cmd([[cabbrev MDPrev MarkdownPreviewToggle]])
