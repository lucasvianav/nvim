vim.opt_local.foldenable = false

require("v.utils.mappings").map({
  "n",
  { "q", "<c-c>" },
  function()
    vim.api.nvim_buf_delete(0, { unload = true, force = true })
  end,
  { buffer = true },
})
