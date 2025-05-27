-- TODO: https://github.com/akinsho/dotfiles/blob/472005850403594c57fba5736a71760aae9b5e2e/.config/nvim/lua/as/plugins/init.lua#L597-L614

local notify = require("notify")
notify.setup({
  stages = "slide",
  merge_duplicates = true,
})

local banned_messages = {
  "no manual entry for",
  "No matching notification found to replace",
  "method textDocument/codeAction is not supported by any of the servers registered for the current buffer",
  "No signature help available",
  "method textDocument/documentHighlight is not supported by any of the servers registered for the current buffer",
  "\"\"",
}

---@diagnostic disable-next-line: duplicate-set-field
vim.notify = function(msg, ...)
  for _, banned in ipairs(banned_messages) do
    if msg:contains(banned) or #msg == 0 then
      return
    end
  end
  notify(msg, ...)
end

require("v.utils.commands").command(
  "Notifications",
  [[
        lua require("telescope").extensions.notify.notify(
            require("telescope.themes").get_dropdown({})
        )
    ]]
)
