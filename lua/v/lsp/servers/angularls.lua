local M = {}

M.config = {
  root_dir = require("lspconfig.util").root_pattern("angular.json"),
}

local mappings = {
  {
    "n",
    "gpt",
    function()
      require("v.utils").open_file_swap_extension("ts")
    end,
  },
  {
    "n",
    "gph",
    function()
      require("v.utils").open_file_swap_extension("html")
    end,
  },
  {
    "n",
    "gps",
    function()
      require("v.utils").open_file_swap_extension("scss")
    end,
  },
}

---@param client any
---@param bufnr integer
function M.on_attach(client, bufnr)
  require("v.lsp.on_attach").disable_formatting(client)
  require("v.utils.mappings").set_keybindings(mappings, { buffer = bufnr })
end

return M
