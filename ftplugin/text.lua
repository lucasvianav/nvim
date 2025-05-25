local o = vim.opt_local

o.textwidth = 0
o.wrap = true

if vim.bo.buftype == "help" then
  vim.cmd.setlocal("nospell")
  require("v.utils.mappings").map({ { "n", "v" }, "q", "<cmd>q<cr>", { buffer = true } })
else
  vim.cmd.setlocal("spell")
end
