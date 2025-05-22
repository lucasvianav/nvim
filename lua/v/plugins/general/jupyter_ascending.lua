require("v.utils.autocmds").augroup("JupyterKeybindings", {
  {
    event = "BufEnter",
    opts = {
      pattern = { "*.sync.py" },
      callback = function()
        require("v.utils.mappings").set_keybindings({
          { "n", "<leader>x", "<Plug>JupyterExecute" },
          { "n", "<leader>xx", "<Plug>JupyterExecuteAll" },
        }, { buffer = true })
      end,
    },
  },
})
