require("v.commands.abbreviations")

require("v.utils.commands").set_commands({
  -- how many times does this pattern appear in the file
  { "Count", "keeppatterns <line1>,<line2>s/<args>//gn | noh", { nargs = 1, range = true } },

  -- saves buffer and then closes it
  { "BqWrite", "update | BufClose" },

  -- LSP
  { "Format", "lua vim.lsp.buf.formatting_sync({}, 1000)" },
  { "FT", "lua vim.lsp.buf.formatting_sync({}, 1000)" },
  { "LQF", "lua vim.diagnostic.setqflist()" },

  -- wrappers
  { "P", "lua require(\"v.utils.wrappers\").inspect(<args>)", { nargs = 1 } },
  { "R", "lua require(\"v.utils\").reload_or_source_current()" },

  -- get filepath for current buffer
  { "FP", "echo expand(\"%\")" },
})
