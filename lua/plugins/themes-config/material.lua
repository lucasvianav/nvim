-- settings
vim.g.material_style = 'deep ocean'
require('material').setup({

    contrast = true, -- Enable contrast for sidebars, floating windows and popup menus like Nvim-Tree
    borders = true, -- Enable borders between verticaly split windows

    italics = {
        comments = true,
        keywords = false,
        functions = false,
        strings = false, 
        variables = false
    },

    -- specify which windows get the contrasted (darker) background
    contrast_windows = { "packer" },

    text_contrast = { lighter = false, darker = false },

    disable = {
        background = true, 
        term_colors = false,
        eob_lines = false
    },

    custom_highlights = {
        -- CursorLine = '',
    }
})

-- activates the colorscheme
if colorscheme == 'material' then 
    vim.cmd('colorscheme material') 
    vim.cmd(appearance_cmds)
end

