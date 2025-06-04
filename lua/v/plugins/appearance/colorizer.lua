require("colorizer").setup({
  filetypes = {
    "*",
    cmp_docs = { always_update = true },
    cmp_menu = { always_update = true },
  },
  buftypes = {},
  user_commands = false,
  lazy_load = true,
  user_default_options = {
    names = false,
    names_opts = {
      lowercase = true,
      camelcase = true,
      uppercase = true,
      ---ignore names with digits - highlight `blue` and `red`, but not `blue3` and `red4`
      strip_digits = false,
    },
    names_custom = false,
    RGB = true,      ---#RGB hex codes
    RGBA = true,     ---#RGBA hex codes
    RRGGBB = true,   ---#RRGGBB hex codes
    RRGGBBAA = true, ---#RRGGBBAA hex codes
    AARRGGBB = true, ---0xAARRGGBB hex codes
    rgb_fn = true,   ---CSS rgb() and rgba() functions
    hsl_fn = true,   ---CSS hsl() and hsla() functions
    css = true,
    css_fn = true,
    tailwind = "both", ---@type boolean|'normal'|'lsp'|'both' Enable tailwind colors
    tailwind_opts = { -- Options for highlighting tailwind names
      update_names = true,
    },
    sass = { enable = true, parsers = { "css" } }, -- Enable sass colors
    mode = "virtualtext", ---@type 'background'|'foreground'|'virtualtext'
    virtualtext = "■",
    virtualtext_inline = "after", ---@type boolean|'before'|'after'
    virtualtext_mode = "foreground", ---@type 'background'|'foreground'
    always_update = false,
    hooks = {
      disable_line_highlight = false,
    },
  },
})
