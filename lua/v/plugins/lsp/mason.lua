local utils = require('v.utils.lsp')
-- local formatters = require('v.settings.lsp').formatters

require('mason').setup()
require('mason-lspconfig').setup({
  ensure_installed = utils.servers,
  automatic_installation = false,
})

for _, server in ipairs(utils.servers) do
  local config = utils.make_config()

  local custom_config_path = 'v.plugins.lsp.servers.' .. server
  local has_custom_config, custom_config = pcall(require, custom_config_path)

  if has_custom_config then
    config = vim.tbl_deep_extend('force', config, custom_config)
  end

  if server == 'lua_ls' then
    local lazydev_loaded, lazydev = require('v.utils.packer').load_and_require_plugin('lazydev')

    if lazydev_loaded then
      lazydev.setup({})
      config = {
        settings = {
          Lua = {
            completion = {
              callSnippet = 'Replace',
            },
          },
        },
      }
    end
  elseif server == 'clangd' then
    config.capabilities.offsetEncoding = 'utf-8'
  end

  require('lspconfig')[server].setup(config)
end
