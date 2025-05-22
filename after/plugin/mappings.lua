local map = require("v.utils.mappings").map
local installed = require("v.utils.packer").is_plugin_installed

if not (installed("better-escape.vim") or installed("better-escape.nvim")) then
  -- move to the right to keep cursor position
  map({ "i", "jk", "col(\".\") == 1 ? \"<esc>\" : \"<esc>l\"", { expr = true } })
end
