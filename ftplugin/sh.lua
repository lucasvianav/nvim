require("v.utils.mappings").set_keybindings({
  ---source/reload current file
  {
    "n",
    "<leader>xx",
    function()
      require("v.utils").reload_or_source_current()
    end,
  },
}, { buffer = true })
