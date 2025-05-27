local M = {}

M.config = {
  filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
  capabilities = {
    offsetEncoding = "utf-8",
  },
}

local mappings = {
  { "n", "gpp", "<cmd>ClangdSwitchSourceHeader<cr>" },
}

---@param _ any
---@param bufnr integer
function M.on_attach(_, bufnr)
  require("v.utils.mappings").set_keybindings(mappings, { buffer = bufnr })
end

return M
