local installed = require("v.utils.packer").is_plugin_installed

if not (installed("better-escape.vim") or installed("better-escape.nvim")) then
  require("v.utils.mappings").map({
    "i",
    "jk",
    -- move to the right to keep cursor position
    "col(\".\") == 1 ? \"<esc>\" : \"<esc>l\"",
    { expr = true },
  })
end
