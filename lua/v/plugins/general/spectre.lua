local spectre = require("spectre")

spectre.setup({
  color_devicons = true,
  open_cmd = "vnew",
  live_update = false, -- auto excute search again when you write any file in vim
  default = {
    find = {
      cmd = "rg",
      options = {},
    },
    replace = { cmd = "sed" },
  },
})

require("v.utils.mappings").set_keybindings({
  { "n", "<Leader>S", spectre.open },
  { "v", "<Leader>S", [[:lua require('spectre').open_visual()<CR>]] },
})

vim.api.nvim_command("command! Spectre lua require(\"spectre\").open()")
