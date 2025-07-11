---@alias CursorBehavior
---| "hold" # cursor follows the node/place on which it was called
---| "start" # cursor jumps to the first symbol of the node being formatted
---| "end" # cursor jumps to the last symbol of the node being formatted

---@class TreesjConfig
---@field use_default_keymaps boolean Use default keymaps (<space>m - toggle, <space>j - join, <space>s - split)
---@field check_syntax_error boolean Node with syntax error will not be formatted
---@field max_join_length number If line after join will be longer than max value, node will not be formatted
---@field cursor_behavior CursorBehavior
---@field notify boolean Notify about possible problems or not
---@field dot_repeat boolean Use `dot` for repeat action
---@field on_error nil|function Callback for treesj error handler. func (err_text, level, ...other_text)

local treesj = require("treesj")
local langs = require("treesj.langs").presets

treesj.setup({ --[[@as TreesjConfig]]
  use_default_keymaps = false,
  check_syntax_error = true,
  max_join_length = 180,
  cursor_behavior = "hold",
  notify = true,
  dot_repeat = true,
  on_error = nil,
})

local function get_filetype_under_cursor()
  local cur_line, cur_col = vim.fn.line("."), vim.fn.col(".")
  local ok_under_cursor, under_cursor = pcall(function()
    return vim.treesitter
      .get_parser()
      :language_for_range({ cur_line, cur_col, cur_line, cur_col })
      :lang()
  end)
  return ok_under_cursor and under_cursor or vim.bo.filetype
end

require("v.utils.mappings").set_keybindings({
  { "n", "g-", treesj.toggle, desc = "Toggle expression split <-> join" },
  {
    "n",
    "gS",
    function()
      if langs[get_filetype_under_cursor()] then
        treesj.split()
      else
        vim.api.nvim_exec2("SplitjoinSplit", { output = false })
      end
    end,
    desc = "Split expression",
  },
  {
    "n",
    "gJ",
    function()
      if langs[get_filetype_under_cursor()] then
        treesj.join()
      else
        vim.api.nvim_exec2("SplitjoinJoin", { output = false })
      end
    end,
    desc = "Join expression",
  },
})
