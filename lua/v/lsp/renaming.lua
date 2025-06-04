local M = {}

---Handler for [textDocument/rename]
---@param err table
---@param result table
---@param ctx table
---@param config table
local function handle_rename(err, result, ctx, config)
  if err then
    vim.notify(
      ("Error running LSP query '%s': %s"):format(ctx.method, err),
      vim.log.levels.ERROR,
      { title = "LSP --- Renaming" }
    )
    return
  end

  -- notification if multiple files updated
  local files = (result and result.changes) and vim.tbl_keys(result.changes) or {}
  if #files > 1 then
    local msg = ("The symbol was renamed in %d files:\n"):format(#files)

    for _, file in ipairs(files) do
      local get_path = require("v.utils").get_relative_path
      msg = msg .. (" - %s\n"):format(get_path(file))
    end

    local prev_name = vim.fn.expand("<cword>")
    local new_name = ctx.params.newName

    msg = msg:sub(1, #msg - 1)
    vim.notify(
      msg,
      vim.log.levels.INFO,
      { title = ("LSP Rename: %s =>> %s"):format(prev_name, new_name) }
    )
  end

  vim.lsp.handlers[ctx.method](err, result, ctx, config)
end

---Confirm/decline the operation
---@param new string
---@param prev string
local rename_callback = function(new, prev)
  new = new and vim.trim(new)

  if not new or #new == 0 or new == prev then
    return
  end

  vim.lsp.buf_request(
    0,
    "textDocument/rename",
    vim.tbl_extend("force", vim.lsp.util.make_position_params(0, "utf-16"), { newName = new }),
    handle_rename
  )
end

---Rename prompt for symbol below cursor.
function M.rename_symbol()
  local curr_word = vim.fn.expand("<cword>")

  require("v.utils.autocmds").augroup("SnacksRename", {
    {
      event = "FileType",
      opts = {
        pattern = "snacks_input",
        callback = function()
          vim.api.nvim_feedkeys(curr_word, "i", false)
          vim.api.nvim_feedkeys(t("<Esc>"), "n", false)
        end,
        once = true,
      },
    },
  })

  vim.ui.input({ prompt = "Rename symbol" }, function(input)
    rename_callback(input, curr_word)
  end)
end

return M
