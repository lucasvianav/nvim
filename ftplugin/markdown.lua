-- in case it's a signature buffer
if vim.bo.buftype == "nofile" then
  vim.opt_local.spell = false
  return
end

vim.opt_local.textwidth = 0
vim.opt_local.synmaxcol = 3000
vim.opt_local.wrap = true
vim.opt_local.spell = true

require("v.utils.mappings").set_keybindings({
  { "i", "<C-i>", "<C-c>xsiw*lf*a" },
  { "i", "<C-h>", "<C-c>xsiw`lf`a" },
  { "i", "<C-b>", "<C-c>xsiw*l.l2f*a" },
  { "i", "<M-i>", "<C-c>xsiW*lf*a" },
  { "i", "<M-h>", "<C-c>xsiW`lf`a" },
  { "i", "<M-b>", "<C-c>xsiW*l.l2f*a" },
  { "v", "<C-i>", "S*" },
  { "v", "<C-b>", "S*gvS*" },
  {
    "n",
    "<Leader>fh",
    function()
      require("telescope").extensions.heading.heading()
    end,
  },
}, {
  buffer = true,
  remap = true,
})
