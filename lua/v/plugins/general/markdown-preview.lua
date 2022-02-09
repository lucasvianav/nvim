require('v.utils').set_viml_options('mkdp', {
    auto_start = false,
    auto_close = false,
    refresh_slow = true,
    open_to_the_world = false,
    browser = 'firefox', -- shell command
})

require('v.utils.abbreviations').cabbrev('MD', 'MarkdownPreviewToggle')
