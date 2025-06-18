vim.opt.pumblend = 0 -- for transparent background
require("catppuccin").setup({
  flavour = "mocha",
  transparent_background = true, -- disables setting the background color.
  show_end_of_buffer = true, -- shows the '~' characters after the end of buffers
  term_colors = false, -- sets terminal colors (e.g. `g:terminal_color_0`)
  dim_inactive = { enabled = false },
  no_italic = false, -- Force no italic
  no_bold = false, -- Force no bold
  no_underline = false, -- Force no underline
  styles = {
    comments = { "italic" },
    conditionals = { "italic" },
    loops = {},
    functions = {},
    keywords = { "italic" },
    strings = {},
    variables = {},
    numbers = {},
    booleans = { "italic" },
    properties = {},
    types = {},
    operators = {},
  },
  native_lsp = {
    enabled = true,
    virtual_text = {
      errors = { "italic" },
      hints = { "italic" },
      warnings = { "italic" },
      information = { "italic" },
      ok = { "italic" },
    },
    underlines = {
      errors = { "underline" },
      hints = { "underline" },
      warnings = { "underline" },
      information = { "underline" },
      ok = { "underline" },
    },
    inlay_hints = {
      background = false,
    },
  },
  color_overrides = {},
  custom_highlights = {},
  default_integrations = true,
  integrations = {
    cmp = true,
    gitsigns = true,
    nvimtree = true,
    treesitter = true,
    notify = true,
    dashboard = true,
    diffview = true,
    fidget = true,
    harpoon = true,
    indent_blankline = {
      enabled = true,
      scope_color = nil, -- catppuccin color (eg. `lavender`) Default: text
      colored_indent_levels = false,
    },
    lightspeed = true,
    mason = true,
    dap = true,
    dap_ui = true,
    nvim_surround = true,
    treesitter_context = true,
    octo = false,
    rainbow_delimiters = true,
    telescope = {
      -- it makes the selection line transparent and I don't like it
      enabled = false,
    },
    lsp_trouble = true,
    which_key = false,
  },
})
