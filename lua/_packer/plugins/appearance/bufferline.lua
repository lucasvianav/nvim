local colors = require('utils').colors

local selected = {
    bg = colors.blacker,
    fg = colors.off_white,
}

local idle = {
    bg = colors.transparent,
    fg = colors.grey,
}

require('bufferline').setup({
    options = {
        numbers = "none",
        left_mouse_command = "buffer %d",
        right_mouse_command = "",
        middle_mouse_command = "bdelete! %d",
        offsets = {{filetype = "NvimTree", text = "File Explorer", text_align = "center"}},
        show_buffer_close_icons = false,
        show_close_icon = false,
        show_tab_indicators = true,
        always_show_bufferline = true,
        tab_size = 13,
    },

    highlights = {
        -- selected buffer
        buffer_selected = {
            guifg = selected.fg,
            guibg = selected.bg
        },
        diagnostic_selected = {
            guibg = selected.bg
        },
        info_selected = {
            guibg = selected.bg
        },
        pick_selected = {
            guibg = selected.bg
        },
        indicator_selected = {
            guibg = selected.bg
        },
        separator_selected = {
            guibg = selected.bg
        },
        duplicate_selected = {
            guibg = selected.bg
        },
        modified_selected = {
            guibg = selected.bg
        },
        error_diagnostic_selected = {
            guibg = selected.bg
        },
        warning_diagnostic_selected = {
            guibg = selected.bg
        },
        warning_selected = {
            guibg = selected.bg
        },
        info_diagnostic_selected = {
            guibg = selected.bg
        },

        -- idle buffers
        fill = {
            guibg = idle.bg
        },
        background = {
            guifg = idle.fg,
            guibg = idle.bg
        },
        diagnostic = {
            guibg = idle.bg
        },
        info = {
            guibg = idle.bg
        },
        pick = {
            guibg = idle.bg
        },
        separator = {
            guibg = idle.bg
        },
        duplicate = {
            guibg = idle.bg
        },
        modified = {
            guibg = idle.bg
        },
        error_diagnostic = {
            guibg = idle.bg
        },
        warning_diagnostic = {
            guibg = idle.bg
        },
        warning = {
            guibg = idle.bg
        },
        info_diagnostic = {
            guibg = idle.bg
        },
        buffer_visible = {
            guifg = idle.fg,
            guibg = idle.bg
        },
        diagnostic_visible = {
            guibg = idle.bg
        },
        info_visible = {
            guibg = idle.bg
        },
        pick_visible = {
            guibg = idle.bg
        },
        separator_visible = {
            guibg = idle.bg
        },
        duplicate_visible = {
            guibg = idle.bg
        },
        modified_visible = {
            guibg = idle.bg
        },
        error_diagnostic_visible = {
            guibg = idle.bg
        },
        warning_diagnostic_visible = {
            guibg = idle.bg
        },
        warning_visible = {
            guibg = idle.bg
        },
        info_diagnostic_visible = {
            guibg = idle.bg
        }
    }
})

