if not (v.plug.is_installed("better-escape.vim") or v.plug.is_installed("better-escape.nvim")) then
  require("v.utils.mappings").map({
    "i",
    "jk",
    -- move to the right to keep cursor position
    "col(\".\") == 1 ? \"<esc>\" : \"<esc>l\"",
    { expr = true },
  })
end
