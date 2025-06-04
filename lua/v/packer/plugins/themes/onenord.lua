require("onenord").setup({
  borders = true, -- split window borders
  italics = {
    comments = true,
    strings = false,
    keywords = true,
    functions = false,
    variables = false,
  },
  disable = {
    background = true,
    cursorline = false,
    eob_lines = false,
  },
  custom_highlights = {},
})
