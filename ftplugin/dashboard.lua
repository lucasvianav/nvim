vim.opt_local.foldenable = false

local alt_file = vim.fn.getreg("#")
local dashboard = require("v.utils.dashboard")
local k = require("v.utils.mappings")

k.map({
  "n",
  { "q", "<c-c>" },
  dashboard.quit_if_curr_buf,
  { buffer = true },
})
k.unmap({ "n", "<BS>", 0 })
vim.api.nvim_exec2("abbreviate <buffer> q qa", { output = false })

require("v.utils.autocmds").augroup("DashboardCleanup", {
  {
    event = "BufWinLeave",
    opts = {
      buffer = 0,
      once = true,
      callback = function(args)
        vim.api.nvim_create_autocmd("BufWinEnter", {
          group = "DashboardCleanup",
          once = true,
          callback = function()
            dashboard.delete_buf(args.buf, alt_file)
          end
        })
      end,
    },
  },
})
