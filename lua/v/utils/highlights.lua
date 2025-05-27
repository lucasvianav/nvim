local M = {}

M.colors = require("v.utils.colors")

---@class HighlighDefinition: vim.api.keyset.highlight
---@field transparent? boolean

---Wrapper for defining highlights like with `:highlight`
---@param groups string|string[] the highlighting groups' names
---@param hldef HighlighDefinition the highlighting modifications
M.highlight = function(groups, hldef)
  groups = type(groups) == "string" and { groups } or groups --[=[@as string[]]=]

  vim.validate("hldef", hldef, "table")
  vim.validate("hldef.link", hldef.link, "string", true)

  if hldef.transparent then
    hldef.ctermbg = "NONE"
    hldef.bg = "NONE"
    hldef.transparent = nil
  end

  for _, group in ipairs(groups) do
    vim.api.nvim_set_hl(0, group, hldef)
  end
end

---@class HighlightTable
---@field groups string|string[] the highlighting groups' names
---@field tbl table<string,string> the highlighting modifications

---Wrapper for defining multiple highlights (`:h :highlight`) in one function call
---@param args HighlightTable[]
---@return nil
M.set_highlights = function(args)
  for _, tbl in ipairs(args) do
    M.highlight(unpack(tbl))
  end
end

---Convert a hex color to RGB
---@param color string
---@return number Red
---@return number Blue
---@return number Green
local function __hex_to_rgb(color)
  local hex = color:gsub("#", "")
  return tonumber(hex:sub(1, 2), 16), tonumber(hex:sub(3, 4), 16), tonumber(hex:sub(5), 16)
end

local function __alter(attr, percent)
  return math.floor(attr * (100 + percent) / 100)
end

---Lighten/darken a specified hex color
---@param color string
---@param percent number (< 0 will darken)
---@return string
---@see https://stackoverflow.com/q/5560248
---@see https://github.com/akinsho/dotfiles/blob/main/.config/nvim/lua/as/highlights.lua
---@see https://stackoverflow.com/a/37797380
function M.alter_color(color, percent)
  local r, g, b = __hex_to_rgb(color)

  if not r or not g or not b then
    return "NONE"
  end

  r, g, b = __alter(r, percent), __alter(g, percent), __alter(b, percent)
  r, g, b = math.min(r, 255), math.min(g, 255), math.min(b, 255)
  return string.format("#%02x%02x%02x", r, g, b)
end

return M
