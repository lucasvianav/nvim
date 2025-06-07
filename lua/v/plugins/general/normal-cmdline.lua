local cmd = require("normal-cmdline")
cmd.setup({
  key = "jk", -- enter normal mode
  mappings = {
    ["<c-k>"] = cmd.history.prev,
    ["<c-j>"] = cmd.history.next,
    ["<cr>"] = cmd.accept,
    ["<c-c>"] = cmd.cancel,
    ["<c-f>"] = function()
      vim.api.nvim_feedkeys("i", "nt", true)
      vim.schedule(vim.schedule_wrap(function()
        vim.api.nvim_feedkeys(t("<c-f>"), "n", false)
      end))
    end,
    [":"] = cmd.reset,
  },
})
