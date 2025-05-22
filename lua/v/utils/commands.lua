-- TODO: accept lua function as rhs
-- https://github.com/akinsho/dotfiles/blob/148d1b720b296ad9ef6943da4e7b9d2c4f86c59b/.config/nvim/lua/as/globals.lua#L320-L334
-- TODO: :h nvim_add_user_command

local M = {}

---Wrapper for defining commands with `:command`
---@param lhs string the command's name
---@param rhs string the command's action
---@param opts? table<string,string|number|boolean> the command's attributes (see `:h :command`)
---@return nil
---
---opts.def_bang is an custom boolean option (default `true`) that specifies if
---the command should be defined with a bang (`:command!` instead of `:command`)
M.command = function(lhs, rhs, opts)
  if (type(lhs) ~= "string" or type(rhs) ~= "string") or (opts and type(opts) ~= "table") then
    vim.notify("Invalid parameter(s).", vim.log.levels.ERROR, {
      title = "Commands",
    })
    require("v.utils.wrappers").inspect(lhs, rhs, opts)
    return
  end

  opts = vim.tbl_extend("force", { def_bang = true }, opts or {})
  local bang = opts.def_bang
  opts.def_bang = nil

  local cmd = "command" .. (bang and "!" or "")

  for opt, value in pairs(opts) do
    if value then
      local setv = type(value) ~= "boolean"
      cmd = ("%s -%s"):format(cmd, opt) .. (setv and "=" .. value or "")
    end
  end

  cmd = ("%s %s %s"):format(cmd, lhs, rhs)

  vim.api.nvim_command(cmd)
end

---Wrapper for defining multiple commands (`:h :command`) in one function call
---@param args string[][] list of command arrays: { lhs, rhs, opts }
---@return nil
M.set_commands = function(args)
  for _, cmd_table in ipairs(args) do
    M.command(unpack(cmd_table))
  end
end

---Clear commandline messages after a few seconds.
---@see http://unix.stackexchange.com/a/613645
---@see https://github.com/akinsho/dotfiles/blob/f714d4cdd2de74c7393ca3ae69bdbb3619e06174/.config/nvim/plugin/autocommands.lua#L130-L156
---@return function
M.clear_cmdline = function()
  --- Track the timer object and stop any previous timers before setting
  --- a new one so that each change waits for 10secs and that 10secs is
  --- deferred each time
  local timer

  return function()
    if timer then
      timer:stop()
    end

    timer = vim.defer_fn(function()
      if vim.api.nvim_get_mode().mode == "n" then
        vim.api.nvim_command([[echon '']])
      end
    end, 10000)
  end
end

return M
