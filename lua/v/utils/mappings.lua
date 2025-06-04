-- TODO: https://github.com/akinsho/dotfiles/blob/c81dadf0c570ce39543a9b43a75f41256ecd03fc/.config/nvim/lua/as/plugins/lspconfig.lua#L61-L119

local M = {}

local logger = require("v.utils.log")
local util = require("v.utils.tables")

---@alias KeybindingMode "n"|"v"|"s"|"x"|"o"|"i"|"l"|"c"|"t"

---@class KeybindingTable
---@field [1|'mode'] KeybindingMode|KeybindingMode[] mode or list of modes (`:h map-modes`)
---@field [2|'lhs'] string|string[] keybinding(s)
---@field [3|'rhs'] string|function action
---@field [4|'opts']? vim.keymap.set.Opts usual map options + `buffer`
---@field desc? string description to be shown in which-key

---@param mode KeybindingMode|KeybindingMode[]
---@param lhs string[]
---@param rhs string|function action
---@param desc? string
---@param buffer integer
local function __create_whichkey_mapping(mode, lhs, rhs, desc, buffer)
  if not desc and type(rhs) ~= "string" then
    return
  end

  local wk_ok, wk = pcall(require, "which-key")

  if not wk_ok then
    return
  end

  for _, lhs_i in ipairs(lhs) do
    wk.add({
      lhs_i,
      mode = mode,
      buffer = buffer,
      desc = desc or tostring(rhs),
    })
  end
end

---Wrapper for `vim.keymap.set`
---@param keybinding KeybindingTable
function M.map(keybinding)
  local desc = keybinding.desc
  keybinding.desc = nil

  local k = util.merge_named_and_pos_fields({
    "mode",
    "lhs",
    "rhs",
    "opts",
  }, keybinding)
  local mode, lhs, rhs, opts = k.mode, k.lhs, k.rhs, k.opts
  lhs = type(lhs) == "string" and { lhs } or lhs --[=[@as string[]]=]

  if #lhs == 0 then
    logger.log("No LHS for mapping.")
    vim.notify("No LHS.", vim.log.levels.ERROR, {
      title = "Mapping",
    })
    return
  end

  local options = vim.tbl_extend("force", {
    silent = true,
    nowait = true, -- TODO: does this break anything?
    replace_keycodes = false,
  }, opts or {}) or {}

  if options.buffer and type(options.buffer) ~= "number" then
    options.buffer = 0
  end

  if options.noremap then
    options.remap = not options.noremap
    options.noremap = nil
  end

  for _, lhs_i in ipairs(lhs) do
    vim.keymap.set(mode, lhs_i, rhs, options)
  end

  __create_whichkey_mapping(mode, lhs, rhs, desc, options.buffer)
end

---@class UnkeybindingTable
---@field [1|'mode'] KeybindingMode|KeybindingMode[] mode to remove keybinding
---@field [2|'lhs'] string keybinding
---@field [3|'buffer']? number buffer id

---Wrapper for `vim.keymap.del`
---@param keybinding UnkeybindingTable
function M.unmap(keybinding)
  local k = util.merge_named_and_pos_fields({
    "mode",
    "lhs",
    "buffer",
  }, keybinding)
  local mode, lhs, buffer = k.mode, k.lhs, k.buffer

  if #lhs == 0 then
    logger.log("No LHS for unmapping.")
    vim.notify("No LHS.", vim.log.levels.ERROR, {
      title = "Unmapping",
    })
    return
  end

  local ok, _ = pcall(vim.keymap.del, mode, lhs, { buffer = buffer })

  if not ok then
    M.map({ mode, lhs, "<nop>", { buffer = buffer } })
  end
end

---@class KeybindingGroup
---@field [1|'lhs']? string keybinding prefix
---@field [2|'group']? string group name

---@class KeybindingsConfig
---@field [number] KeybindingTable
---@field group? KeybindingGroup
---@field groups? KeybindingGroup[]

---@param group? KeybindingGroup
---@param groups? KeybindingGroup[]
---@param buffer? integer|boolean
local function __create_whichkey_group(group, groups, buffer)
  buffer = type(buffer) == "boolean" and 1 or buffer --[[@as integer]]
  groups = groups or {}

  if group then
    table.insert(groups, group)
  end

  if #groups == 0 then
    return
  end

  local wk_ok, wk = pcall(require, "which-key")

  if not wk_ok then
    return
  end

  for _, grp in ipairs(groups) do
    local g = util.merge_named_and_pos_fields({
      "lhs",
      "grp",
    }, grp)
    local lhs, name = g.lhs, g.group

    if lhs and name then
      wk.add({
        lhs,
        buffer = buffer,
        grp = name,
      })
    end
  end
end

---Sets a list of keybindings.
---@param args KeybindingsConfig parameters to be passed to v.utils.mappings.map
---@param common_opts? vim.keymap.set.Opts options to all keybindings
---@see v.utils.mappings.map
function M.set_keybindings(args, common_opts)
  __create_whichkey_group(args.group, args.groups, (common_opts or {}).buffer)

  for _, map_table in ipairs(args) do
    local desc = map_table.desc
    map_table.desc = nil

    local k = util.merge_named_and_pos_fields({
      "mode",
      "lhs",
      "rhs",
      "opts",
    }, map_table)
    local options = vim.tbl_extend("force", common_opts or {}, k.opts or {})

    M.map({ k.mode, k.lhs, k.rhs, options, desc = desc })
  end
end

---Unsets a list of keybindings.
---@param args UnkeybindingTable[] parameters to be passed to v.utils.mappings.unmap
---@see v.utils.mappings.unmap
function M.unset_keybindings(args)
  for _, map_table in ipairs(args) do
    local k = util.merge_named_and_pos_fields({
      "mode",
      "lhs",
      "buffer",
    }, map_table)

    M.unmap({ k.mode, k.lhs, k.buffer })
  end
end

return M
