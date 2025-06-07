require("v.utils.autocmds").augroup("MakeDirP", {
  {
    event = { "BufWritePre", "FileWritePre" },
    opts = {
      pattern = "*",
      callback = function(event)
        if not event.file:starts_with("oil://") then
          local filepath = vim.fs.dirname(vim.fs.abspath(event.file))
          pcall(vim.fn.mkdir, filepath, "p")
        end
      end,
    },
  },
})
