local M = {}

---Kind of a hack so files aren't folded in telescope previewers.
---Should be called in ftplugin files.
function M.prevent_folding()
  vim.opt_local.foldenable = false
  vim.opt_local.foldlevel = 99

  local original_foldlevelstart = vim.o.foldlevelstart
  vim.opt.foldlevelstart = -1

  require("v.utils.autocmds").augroup("TelescopeFolding", {
    {
      event = { "BufEnter", "BufWinEnter", "WinEnter", "CmdwinEnter" },
      opts = {
        once = true,
        callback = function()
          if vim.bo.filetype ~= "TelescopeResults" then
            vim.opt.foldlevelstart = original_foldlevelstart
          end
        end,
      },
    },
  })
end

return M
