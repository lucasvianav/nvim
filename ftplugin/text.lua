local o = vim.opt_local

o.textwidth = 0
o.wrap = true

if vim.bo.buftype == "help" then
  vim.opt_local.spell = false
  require("v.utils.mappings").map({ { "n", "v" }, "q", "<cmd>q<cr>", { buffer = true } })
else
  vim.opt_local.spell = true
end
