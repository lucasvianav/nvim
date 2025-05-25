require("v.utils.autocmds").augroup("FoldingManager", {
  {
    event = "BufRead",
    opts = {
      callback = function(event)
        vim.api.nvim_create_autocmd("BufWinEnter", {
          group = "FoldingManager",
          once = true,
          buffer = event.buf,
          callback = function()
            vim.api.nvim_exec2("normal! zx", { output = false })
          end,
        })
      end,
    },
  },
})
