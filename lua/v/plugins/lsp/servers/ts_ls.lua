local M = {}

local packer = require("v.utils.packer")
local utils = require("v.utils.mappings")

M.config = {
  init_options = {
    hostInfo = "neovim",
    preferences = {
      includeInlayParameterNameHints = "all",
      includeInlayParameterNameHintsWhenArgumentMatchesName = true,
      includeInlayFunctionParameterTypeHints = true,
      includeInlayVariableTypeHints = true,
      includeInlayPropertyDeclarationTypeHints = true,
      includeInlayFunctionLikeReturnTypeHints = true,
      includeInlayEnumMemberValueHints = true,
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
  require("v.utils.lsp.on_attach").disable_formatting(client)

  -- if it's in an angular project, [angularls] will take care of renaming
  if vim.fn.filereadable(vim.fs.joinpath(vim.uv.cwd(), "angular.json")) then
    client.server_capabilities.renameProvider = false
  end

  if packer.load_plugin("typescript-tools.nvim", true) then
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

M.skip_lsp_setup = packer.is_plugin_installed("typescript-tools.nvim")

return M
