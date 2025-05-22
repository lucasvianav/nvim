-- TODO: https://github.com/akinsho/dotfiles/blob/f714d4cdd2de74c7393ca3ae69bdbb3619e06174/.config/nvim/lua/as/globals.lua#L211-L243
-- TODO: :h nvim_create_autocmd, :h nvim_create_augroup

local M = {}

---@class AutocommandOptions
---@field pattern? string|string[]
---@field buffer? integer
---@field desc? string
---@field callback? fun(id: number, event: number|nil, group: number|nil, match: string, buf: number, file: string)|string
---@field command? string
---@field once? boolean
---@field nested? boolean

---@class Autocommand
---@field event string|string[]
---@field opts? AutocommandOptions

---Wrapper for creating a new augroup and associating a list of commands to it.
---@param name string
---@param autocmds Autocommand[] will be unpacked and passed to nvim_create_autocmd
---@param opts? AutocommandOptions
---@return nil
M.augroup = function(name, autocmds, opts)
  if type(name) ~= "string" or type(autocmds) ~= "table" then
    vim.api.nvim_notify("Invalid parameter(s).", vim.log.levels.ERROR, {
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
