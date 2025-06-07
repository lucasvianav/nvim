---@module "notify"
---@module "fidget.notification"

local M = {}

---@type string[]
local banned_messages = {
  "No matching notification found to replace",
  "No signature help available",
  "[LSP] Format request failed, no matching language servers.",
  "\"\"",
  "method textDocument/codeAction is not supported by any of the servers registered for the current buffer",
  "method textDocument/documentHighlight is not supported by any of the servers registered for the current buffer",
  "method textDocument/signatureHelp is not supported by any of the servers registered for the current buffer",
  "no manual entry for",
}

---@type table<string, vim.log.levels>
local override_level = {
  ["No results found for `lsp_definitions`"] = vim.log.levels.DEBUG,
}

---@param msg string
---@param level vim.log.levels
---@param opts notify.Options | Options
function M.notify(msg, level, opts)
  if #msg == 0 then
    return
  end

  for _, it in ipairs(banned_messages) do
    if msg:contains(it) then
      return
    end
  end

  for it, override in pairs(override_level) do
    if msg:contains(it) then
      level = override
      break
    end
  end

  v.notify(msg, level, opts)
end

return M
