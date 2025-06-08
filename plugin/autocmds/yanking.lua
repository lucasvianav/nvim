v.augroup("YankHighlight", {
  {
    event = "TextYankPost",
    opts = {
      pattern = "*",
      callback = function()
        pcall(vim.highlight.on_yank)
      end,
    },
  },
})
