local M = {}

local utils = require("v.utils.mappings")

M.config = {
  init_options = {
    hostInfo = "neovim",
    preferences = {
      includeInlayParameterNameHints = "none",
      includeInlayParameterNameHintsWhenArgumentMatchesName = false,
      includeInlayFunctionParameterTypeHints = false,
      includeInlayVariableTypeHints = false,
      includeInlayPropertyDeclarationTypeHints = false,
      includeInlayFunctionLikeReturnTypeHints = false,
      includeInlayEnumMemberValueHints = false,
    },
  },
}

local function typescript_sort_imports(bufnr, post)
  local attached_clients = vim.lsp.get_clients({ bufnr = bufnr })
  local ts_ls_attached = vim.iter(attached_clients):any(function(it)
    return it.name == "ts_ls"
  end)

  if not ts_ls_attached then
    return
  end

  bufnr = bufnr or vim.api.nvim_get_current_buf()
  local params = {
    command = "_typescript.organizeImports",
    arguments = { vim.api.nvim_buf_get_name(bufnr) },
    title = "",
  }

  vim.lsp.buf_request(bufnr, "workspace/executeCommand", params, function(err)
    if not err and post then
      post()
    end
  end)
end

function M.on_attach(client, bufnr)
  require("v.lsp.on_attach").disable_formatting(client)

  -- if it's in an angular project, [angularls] will take care of renaming
  if vim.fn.filereadable(vim.fs.joinpath(vim.uv.cwd(), "angular.json")) then
    client.server_capabilities.renameProvider = false
  end

  if v.plug.is_loaded("typescript-tools.nvim") then
    require("v.utils.autocmds").augroup("SortImportsTS", {
      { event = "BufWritePre", opts = { command = "TSToolsOrganizeImports", buffer = 0 } },
    })

    utils.map({ "n", "<leader>si", "<cmd>TSToolsOrganizeImports<CR>" })
  else
    utils.map({
      "n",
      "<leader>si",
      function()
        typescript_sort_imports(bufnr)
      end,
      { buffer = bufnr },
    })
  end
end

M.skip_lsp_setup = v.plug.is_installed("typescript-tools.nvim")

return M
