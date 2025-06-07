local def_notification_conf = require("fidget.notification").default_config
local fidget = require("fidget")

-- guarantee folding will be disabled on the window whenever it is created
local win_set_local_options = fidget.notification.window.win_set_local_options
---@diagnostic disable-next-line: duplicate-set-field
fidget.notification.window.win_set_local_options = function(winnr, ...)
  win_set_local_options(winnr, ...)
  vim.api.nvim_set_option_value("foldenable", false, { win = winnr })
end

fidget.setup({
  progress = { -- lsp
    poll_rate = 0,
    suppress_on_insert = false,
    ignore_done_already = true,
    ignore_empty_message = true,
    notification_group = function(msg)
      return "[lsp] " .. msg.lsp_client.name
    end,
    ignore = {},
    display = {
      render_limit = 16,
      progress_ttl = math.huge,
      skip_history = true, -- whether progress notifications should be omitted from history
    },
  },
  notification = {
    filter = vim.log.levels.DEBUG,
    history_size = 128,
    override_vim_notify = false,
    configs = {
      default = vim.tbl_extend("force", def_notification_conf, {
        name = "[notif]",
        icon = "",
      }),
    },
    redirect = function(msg, level, opts)
      if ((opts or {}).group or ""):starts_with("[lsp]") then
        return false
      elseif type(level) ~= "number" or level > vim.log.levels.DEBUG then
        return require("fidget.integration.nvim-notify").delegate(msg, level, opts)
      end
    end,
    view = {
      stack_upwards = true,
      icon_separator = " ",
      group_separator = "---",
      group_separator_hl = "Comment",
      render_message = function(
        msg --[[@param msg string]],
        count --[[@param count integer]]
      )
        local message = msg:wrap(fidget.notification.options.window.max_width)
        return count == 1 and message or string.format("(%sx) %s", count, message)
      end,
    },
    window = {
      max_width = math.min(math.floor(vim.o.columns * 0.45), 125),
      max_height = math.min(math.floor(vim.o.lines * 0.45), 25),
    },
  },
  integration = {
    ["nvim-tree"] = {
      enable = true,
    },
  },
})

v.notify = fidget.notify

v.augroup("FidgetDimensions", {
  {
    event = "VimResized",
    opts = {
      callback = function(_)
        fidget.notification.options.window.max_width =
          math.min(math.floor(vim.o.columns * 0.45), 125)
        fidget.notification.options.window.max_height = math.min(math.floor(vim.o.lines * 0.45), 25)
      end,
    },
  },
})
