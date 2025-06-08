-- TODO: https://github.com/akinsho/dotfiles/blob/472005850403594c57fba5736a71760aae9b5e2e/.config/nvim/lua/as/plugins/init.lua#L597-L614
-- TODO: https://github.com/rcarriga/nvim-notify?tab=readme-ov-file#usage

local notify = require("notify")

notify.setup({
  stages = "slide",
  merge_duplicates = true,
  on_open = function(winnr)
    vim.api.nvim_set_option_value("foldenable", false, { win = winnr })
  end,
})

if not v.plug.is_loaded("fidget.nvim") then
  v.notify = notify
end

require("v.utils.commands").command(
  "Notifications",
  [[
        lua require("telescope").extensions.notify.notify(
            require("telescope.themes").get_dropdown({})
        )
    ]]
)
