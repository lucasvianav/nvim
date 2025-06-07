local M = {}

local util = require("v.utils.tables")

---Wrapper for creating a new augroup and associating a list of commands to it.
---@param name string
---@param autocmds Autocmd[] will be unpacked and passed to nvim_create_autocmd
---@param opts? vim.api.keyset.create_autocmd
---@return nil
function M.augroup(name, autocmds, opts)
  if type(name) ~= "string" or type(autocmds) ~= "table" then
    vim.notify("Invalid parameter(s).", vim.log.levels.ERROR, {
      title = "Augroups",
    })
    require("v.utils.wrappers").inspect(name, autocmds)
    return
  end

  local global_opts = opts or {}
  global_opts.group = vim.api.nvim_create_augroup(name, { clear = true })

  for _, it in ipairs(autocmds) do
    local input = util.merge_named_and_pos_fields({ "event", "opts" }, it)
    local local_opts = vim.tbl_deep_extend("keep", input.opts or {}, global_opts)

    local_opts.group = global_opts.group

    if type(local_opts.buffer) == "boolean" and local_opts.buffer then
      local_opts.buffer = 0
    end

    vim.api.nvim_create_autocmd(input.event, local_opts)
  end
end

return M
