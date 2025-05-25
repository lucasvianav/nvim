require("v.utils.mappings").set_keybindings({
  -- execute current line/selection
  {
    { "n", "v" },
    "<leader>x",
    function()
      require("v.utils").exec_line_or_make()
    end,
  },

  ---source/reload current file
  {
    { "n" },
    "<leader>xx",
    function()
      require("v.utils").reload_or_source_current()
    end,
  },
}, { buffer = true })
