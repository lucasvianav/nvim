require('v.utils').set_viml_options('mkdp', {
    auto_start        = false,
    auto_close        = false,
    refresh_slow      = true,
    open_to_the_world = false,
    browser           = 'brave-browser', -- khell command
})

vim.cmd([[cabbrev MDPrev MarkdownPreviewToggle]])
