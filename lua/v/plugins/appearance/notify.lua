local notify = require("notify")

notify.setup({
  stages = "slide",
  merge_duplicates = true,
  on_open = function(winnr)
    vim.api.nvim_set_option_value("foldenable", false, { win = winnr })
    vim.api.nvim_set_option_value("filetype", "markdown", { buf = vim.api.nvim_win_get_buf(winnr) })
  end,
})

if not v.plug.is_loaded("fidget.nvim") then
  v.notify = notify
end

require("v.utils.mappings").map({
  "n",
  "<leader>fN",
  function()
    require("telescope").extensions.notify.notify(
      require("v.plugins.navigation.telescope.themes").ivy
    )
  end,
})
vim.api.nvim_create_user_command("Notifications", function()
  require("telescope").extensions.notify.notify(
    require("v.plugins.navigation.telescope.themes").ivy
  )
end, {})
