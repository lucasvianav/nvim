-- TODO: https://github.com/akinsho/dotfiles/blob/main/.config/nvim/lua/as/plugins/whichkey.lua
-- TODO: how to not group with multiple keys?

local wk = require("which-key")

---@param str string
---@return boolean
local function __is_function_ref(str)
  local _, count = str:gsub("^function: 0x", "")
  return count > 0
end

---@diagnostic disable-next-line: missing-fields
wk.setup({
  preset = "modern",
  expand = 2,
  show_help = true,
  notify = true,
  delay = 300,
  filter = function(m)
    return m.desc and m.desc ~= "" and not __is_function_ref(m.desc)
  end,
  plugins = {
    marks = true,
    registers = false,
    spelling = { enabled = false },
    presets = {
      operators = false,
      motions = false,
      text_objects = false,
      windows = true,
      nav = false,
      z = false,
      g = false,
    },
  },
  icons = {
    breadcrumb = "»", -- shows your active key combo
    separator = "➜", -- used between a key and it's label
    group = "+", -- prepended to a group
    keys = {
      Up = "<up>",
      Down = "<down>",
      Left = "<left>",
      Right = "<right>",
      C = "<ctrl>",
      M = "<alt>",
      D = "<cmd>",
      S = "<shift>",
      CR = "<cr>",
      Esc = "<esc>",
      ScrollWheelDown = "󱕐 ",
      ScrollWheelUp = "󱕑 ",
      NL = "<nl>",
      BS = "<bs>",
      Space = "󱁐 ",
      Tab = "<tab>",
      F1 = "<F1>",
      F2 = "<F2>",
      F3 = "<F3>",
      F4 = "<F4>",
      F5 = "<F5>",
      F6 = "<F6>",
      F7 = "<F7>",
      F8 = "<F8>",
      F9 = "<F9>",
      F10 = "<F10>",
      F11 = "<F11>",
      F12 = "<F12>",
    },
  },
  win = {
    no_overlap = false,
    border = "rounded",
    -- row = 34,
    -- col = 20,
    -- height = 15,
    -- width = 270,
    -- position = 'bottom',
    padding = { 2, 2 },
  },
})

-- extend the background to below the border
require("v.utils.highlights").highlight("WhichKeyBorder", { link = "WhichKeyNormal" })

-- TODO: hide cursor in whichkey window (see :h winhighlight)
-- require('v.utils.autocmds').augroup('WhichKeyStatusLine', {
--   {
--     event = 'FileType',
--     opts = {
--       pattern = 'wk',
--       command = 'set noruler | autocmd BufLeave <buffer> set ruler',
--     },
--   },
-- })
