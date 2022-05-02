local t = require('v.utils.wrappers').termcode
local fn = vim.fn

-- TODO: setup whichkey registering on the fly
-- https://github.com/folke/which-key.nvim#-setup
-- https://github.com/akinsho/dotfiles/blob/c81dadf0c570ce39543a9b43a75f41256ecd03fc/.config/nvim/lua/as/plugins/lspconfig.lua#L61-L119
-- https://github.com/folke/which-key.nvim/issues/153

local M = {}

---Wrapper for `vim.keymap.set`
---@param mode string|string[] mode or list of modes (`:h map-modes`)
---@param lhs string keybinding
---@param rhs string|function action
---@param opts table<string, boolean|string> usual map options + `buffer` (`:h vim.keymap.set`)
function M.map(mode, lhs, rhs, opts)
  if not lhs then
    vim.api.nvim_notify('No LHS.', vim.log.levels.ERROR, {
      title = 'Mapping',
    })
    return
  end

  local options = vim.tbl_extend('force', {
    silent = true,
    nowait = true, -- TODO: does this break anything?
    replace_keycodes = false,
  }, opts or {})

  local buffer = options.buffer
  if buffer and type(buffer) ~= 'number' then
    buffer = 0
  end

  vim.keymap.set(mode, lhs, rhs, options)
end

---Wrapper for `vim.keymap.del`
---@param mode string|string[] mode or list of modes (`:h map-modes`)
---@param lhs string keybinding
---@param buffer? number buffer id
function M.unmap(mode, lhs, buffer)
  if not lhs then
    vim.api.nvim_notify('No LHS.', vim.log.levels.ERROR, { title = 'Unmapping' })
    return
  end

  local ok, _ = pcall(vim.keymap.del, mode, lhs, { buffer = buffer })

  if not ok then
    M.map(mode, lhs, t('<nop>'), { buffer = buffer })
  end
end

---@class KeybindingTable
---@field mode string|string[] mode or list of modes (`:h map-modes`)
---@field lhs string keybinding
---@field rhs string|function action
---@param opts table<string, boolean|string> usual map options + `buffer` (`:h vim.keymap.set`)

---Sets a list of keybindings.
---@param args KeybindingTable[] parameters to be passed to v.utils.mappings.map
---@param common_opts table<string, boolean|string> options to be appled to all keybindings. The keybinding's individual options have higher prority.
---@see v.utils.mappings.map
function M.set_keybindings(args, common_opts)
  for _, map_table in ipairs(args) do
    local mode, lhs, rhs, opts = unpack(map_table)
    local options = vim.tbl_extend('force', common_opts or {}, opts or {})
    M.map(mode, lhs, rhs, options)
  end
end

---@class UnkeybindingTable
---@field mode string|string[] mode or list of modes (`:h map-modes`)
---@field lhs string keybinding
---@param buffer? number buffer id

---Unsets a list of keybindings.
---@param args UnkeybindingTable[] parameters to be passed to v.utils.mappings.unmap
---@see v.utils.mappings.unmap
function M.unset_keybindings(args)
  for _, map_table in ipairs(args) do
    M.unmap(unpack(map_table))
  end
end

---`<CR>` action compatible with nvim-autopairs and completion plugins.
function M.CR()
  local has_npairs, npairs = pcall(require, 'nvim-autopairs')

  if fn.pumvisible() ~= 0 then
    if fn.complete_info({ 'selected' }).selected == -1 then
      return has_npairs and (npairs.esc('<c-e>') .. npairs.autopairs_cr()) or t('<C-e><CR>')
    else
      return has_npairs and npairs.esc('<c-y>') or t('<C-y>')
    end
  else
    return has_npairs and npairs.autopairs_cr() or t('<CR>')
  end
end

---`<BS>` action compatible with nvim-autopairs and completion plugins.
function M.BS()
  local has_npairs, npairs = pcall(require, 'nvim-autopairs')

  if fn.pumvisible() ~= 0 and fn.complete_info({ 'mode' }).mode == 'eval' then
    return has_npairs and (npairs.esc('<c-e>') .. npairs.autopairs_bs()) or t('<C-e><BS>')
  else
    return has_npairs and npairs.autopairs_bs() or t('<BS>')
  end
end

return M
