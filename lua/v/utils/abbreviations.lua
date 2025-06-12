local M = {}

local util = require("v.utils.tables")

---@param mode string
---@return boolean is_mode_valid
local function validate_mode(mode)
  if type(mode) ~= "string" then
    vim.notify("Invalid mode. See `:messages`", vim.log.levels.ERROR, {
      title = "Abbreviation",
    })
    require("v.utils.wrappers").inspect(mode)
  elseif not string.find("!ci", mode) or #mode ~= 1 then
    vim.notify("Invalid mode: " .. mode, vim.log.levels.ERROR, {
      title = "Abbreviation",
    })
  else
    return true
  end

  return false
end

---Evaluates the result of a command-line abbreviation.
---@param lhs string abbreviation-trigger
---@param rhs string abbreviation-result
M.evaluate_cabbrev = function(lhs, rhs)
  local is_ex = vim.fn.getcmdtype() == ":"
  local cmd = vim.fn.getcmdline()
  local should_expand = cmd:match("^" .. vim.pesc(lhs)) or cmd:match("|%s*" .. vim.pesc(lhs))

  return (is_ex and should_expand) and rhs or lhs
end

---Wrapper for :cabbreviate and :iabbreviate
---@param mode "i"|"c"|"!" insert, cmdline or both
---@param lhs string abbreviation-trigger
---@param rhs string abbreviation-result
---@param opts { buffer: boolean? }?
---@return nil
M.abbreviate = function(mode, lhs, rhs, opts)
  if not validate_mode(mode) then
    return
  elseif not type(lhs) == "string" or not type(rhs) == "string" then
    vim.notify("Invalid parameter(s).", vim.log.levels.ERROR, {
      title = "Abbreviation",
    })
    require("v.utils.wrappers").inspect(mode, lhs, rhs)
    return
  end

  opts = opts or {}

  if mode == "i" or mode == "!" then
    vim.api.nvim_command(("iabbrev %s %s"):format(lhs, rhs))
  end

  if mode == "c" or mode == "!" then
    local path = "v:lua.require(\"v.utils.abbreviations\").evaluate_cabbrev"
    local buffer = opts.buffer and "<buffer> " or ""
    local cmd = "cabbrev %s<expr> %s %s(\"%s\", \"%s\")"
    vim.api.nvim_exec2(cmd:format(buffer, lhs, path, lhs, rhs), { output = false })
  end
end

---Wrapper for :cabbreviate
---@param lhs string abbreviation-trigger
---@param rhs string abbreviation-result
M.cabbrev = function(lhs, rhs)
  M.abbreviate("c", lhs, rhs)
end

---Wrapper for :iabbreviate
---@param lhs string abbreviation-trigger
---@param rhs string abbreviation-result
M.iabbrev = function(lhs, rhs)
  M.abbreviate("i", lhs, rhs)
end

---@alias AbbreviationMode "i"|"c"|"!"

---@class Abbreviation
---@field [1|"lhs"] string|string[]
---@field [2|"rhs"] string
---@field [3|"mode"]? AbbreviationMode|AbbreviationMode[]
---@field [4|"opts"]? { buffer: boolean? }?

---@param args Abbreviation[]
---@param mode AbbreviationMode?
M.set_abbreviations = function(args, mode)
  if mode and not validate_mode(mode) then
    return
  end

  for _, abbrev_table in ipairs(args) do
    local a = util.merge_named_and_pos_fields({
      "lhs",
      "rhs",
      "mode",
      "opts",
    }, abbrev_table)

    local modes = (type(a.mode) == "table" and a.mode or (a.mode and { a.mode } or { mode })) --[=[@as AbbreviationMode[]]=]
    local lhs = (type(a.lhs) == "table" and a.lhs or { a.lhs }) --[=[@as string[]]=]

    for _, l in ipairs(lhs) do
      for _, m in ipairs(modes or { "!" }) do
        M.abbreviate(m, l, a.rhs, a.opts)
      end
    end
  end
end

return M
