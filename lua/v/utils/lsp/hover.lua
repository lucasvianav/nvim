local M = {}
local lsp = vim.lsp

local hover_config = {
  border = "rounded",
  ---@see https://github.com/akinsho/dotfiles/blob/d3526289627b72e4b6a3ddcbfe0411b5217a4a88/.config/nvim/plugin/lsp.lua#L145-L158
  max_width = math.max(math.floor(vim.o.columns * 0.7), 100),
  max_height = math.max(math.floor(vim.o.lines * 0.3), 30),
}

---Peek definition for symbl below the cursor
function M.peek_definition()
  -- TODO: https://github.com/rmagatti/goto-preview
  return vim.lsp.buf_request(
    0,
    "textDocument/typeDefinition",
    lsp.util.make_position_params(0, "utf-16"),
    function(_, result)
      if result == nil or vim.tbl_isempty(result) then
        return nil
      end
      lsp.util.preview_location(result[1], hover_config)
    end
  )
end

function M.hover()
  vim.lsp.buf.hover(hover_config)
end

function M.signature_help()
  vim.lsp.buf.signature_help(hover_config)
end

---Calls LSP hover or activates Vim doc (:h) depending on filetype.
---@return nil
function M.smart_docs()
  if vim.tbl_contains({ "vim", "help", "lua" }, vim.o.filetype) then
    local has_docs = pcall(vim.api.nvim_command, "help " .. vim.fn.expand("<cword>"))
    if has_docs then
      return
    end
  end

  vim.lsp.buf.hover({ border = "rounded" })
end

return M
