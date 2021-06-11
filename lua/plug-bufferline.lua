selected_bg = ''
idle_bg = ''

selected_fg = '#f7f7f7'
idle_fg = 'grey'

selected_bg = '#0a0a0a'
-- idle_bg = '#252626'

-- selected_fg = '#fcd6d7'

require('bufferline').setup{
    options = {
        numbers = "none",
        left_mouse_command = "buffer %d",
        right_mouse_command = "",
        middle_mouse_command = "bdelete! %d",
        offsets = {{filetype = "coc-explorer", text = "File Explorer", text_align = "center"}},
        show_buffer_close_icons = false,
        show_close_icon = false,
        show_tab_indicators = true,
        always_show_bufferline = true,
        tab_size = 13
    },

    highlights = {
        -- selected_bg buffer
        buffer_visible = {
            guifg = selected_fg,
            guibg = selected_bg
        },
        buffer_selected = {
            guifg = selected_fg,
            guibg = selected_bg
        },
        diagnostic_visible = {
            guibg = selected_bg
        },
        diagnostic_selected = {
            guibg = selected_bg
        },
        info_visible = {
            guibg = selected_bg
        },
        info_selected = {
            guibg = selected_bg
        },
        pick_selected = {
            guibg = selected_bg
        },
        pick_visible = {
            guibg = selected_bg
        },
        indicator_selected = {
            guibg = selected_bg
        },
        separator_selected = {
            guibg = selected_bg
        },
        separator_visible = {
            guibg = selected_bg
        },
        duplicate_selected = {
            guibg = selected_bg
        },
        duplicate_visible = {
            guibg = selected_bg
        },
        modified_visible = {
            guibg = selected_bg
        },
        modified_selected = {
            guibg = selected_bg
        },
        error_diagnostic_visible = {
            guibg = selected_bg
        },
        error_diagnostic_selected = {
            guibg = selected_bg
        },
        warning_diagnostic_visible = {
            guibg = selected_bg
        },
        warning_diagnostic_selected = {
            guibg = selected_bg
        },
        warning_visible = {
            guibg = selected_bg
        },
        warning_selected = {
            guibg = selected_bg
        },
        info_diagnostic_visible = {
            guibg = selected_bg
        },
        info_diagnostic_selected = {
            guibg = selected_bg
        },



        -- idle_bg buffers
        fill = {
            guibg = idle_bg
        },
        background = {
            guifg = idle_fg,
            guibg = idle_bg
        },
        diagnostic = {
            guibg = idle_bg
        },
        info = {
            guibg = idle_bg
        },
        pick = {
            guibg = idle_bg
        },
        separator = {
            guibg = idle_bg
        },
        duplicate = {
            guibg = idle_bg
        },
        modified = {
            guibg = idle_bg
        },
        error_diagnostic = {
            guibg = idle_bg
        },
        warning_diagnostic = {
            guibg = idle_bg
        },
        warning = {
            guibg = idle_bg
        },
        info_diagnostic = {
            guibg = idle_bg
        },
    };
}
