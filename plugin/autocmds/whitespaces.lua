---Deletes all trailing whitespaces in a file if it's not binary nor a diff.
v.augroup("TrimTrailingWhitespaces", {
  {
    event = "BufWritePre",
    opts = {
      pattern = "*",
      callback = function()
        if not vim.bo.binary and vim.bo.filetype ~= "diff" then
          local current_view = vim.fn.winsaveview()
          vim.api.nvim_exec2([[keeppatterns %s/\s\+$//e]], { output = false })
          vim.fn.winrestview(current_view)
        end
      end,
    },
  },
})
