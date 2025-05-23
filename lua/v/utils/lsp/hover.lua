local M = {}
local lsp = vim.lsp

-- TODO: https://www.reddit.com/r/neovim/comments/qpfc25/telescope_preview_definition/
---Peek definition for symbl below the cursor
function M.peek_definition()
  return vim.lsp.buf_request(
    0,
    "textDocument/definition",
    lsp.util.make_position_params(0, "utf-16"),
    function(_, result)
      if result == nil or vim.tbl_isempty(result) then
        return nil
      end
      lsp.util.preview_location(result[1])
    end
  )
end

---Calls LSP hover or activates Vim doc (:h) depending on filetype.
---@return nil
function M.smart_hover_docs()
  if vim.tbl_contains({ "vim", "help", "lua" }, vim.o.filetype) then
    local has_docs = pcall(vim.api.nvim_command, "help " .. vim.fn.expand("<cword>"))
    if has_docs then
      return
    end
  end

  vim.lsp.buf.hover()
end

return M
