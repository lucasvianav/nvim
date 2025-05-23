local M = {}

local lsp = vim.lsp
local fn = vim.fn
local api = vim.api

---Handler for [textDocument/formatting]
---@param err table
---@param result table
---@param ctx table
---@param config table
---@return nil
function M.handle_formatting(err, result, ctx, config)
  if err ~= nil or result == nil then
    return
  end

  local bufnr = ctx.bufnr
  local buf_modified = api.nvim_get_option_value("modified", { buf = bufnr })

  if not buf_modified then
    local view = fn.winsaveview()
    lsp.util.apply_text_edits(result, bufnr, "utf-16")
    fn.winrestview(view)

    if bufnr == api.nvim_get_current_buf() then
      vim.api.nvim_command("noautocmd :update")
    else
      vim.notify(
        "Formatted buffer " .. bufnr,
        vim.log.levels.INFO,
        { title = "LSP --- Formatting" }
      )
    end
  end
end

return M
