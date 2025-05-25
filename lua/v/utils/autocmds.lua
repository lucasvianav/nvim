-- TODO: https://github.com/akinsho/dotfiles/blob/f714d4cdd2de74c7393ca3ae69bdbb3619e06174/.config/nvim/lua/as/globals.lua#L211-L243
-- TODO: :h nvim_create_autocmd, :h nvim_create_augroup

local M = {}

---@class Autocommand
---@field event string|string[]
---@field opts? vim.api.keyset.create_autocmd

---Wrapper for creating a new augroup and associating a list of commands to it.
---@param name string
---@param autocmds Autocommand[] will be unpacked and passed to nvim_create_autocmd
---@param opts? vim.api.keyset.create_autocmd
---@return nil
M.augroup = function(name, autocmds, opts)
  if type(name) ~= "string" or type(autocmds) ~= "table" then
    vim.notify("Invalid parameter(s).", vim.log.levels.ERROR, {
      title = "Augroups",
    })
    require("v.utils.wrappers").inspect(name, autocmds)
    return
  end

  opts = opts or {}
  opts.group = vim.api.nvim_create_augroup(name, { clear = true })

  for _, tbl in ipairs(autocmds) do
    opts = vim.tbl_extend("keep", tbl.opts or {}, opts)

    if type(opts.buffer) == "boolean" then
      opts.buffer = 0
    end

    vim.api.nvim_create_autocmd(tbl.event, opts)
  end
end

return M
