local utils = require('v.utils.lsp')

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
    local is_packer_loaded, packer = require('v.utils.packer').get_packer()
    if is_packer_loaded then
      packer.loader('neodev')
    end

    local neodev_loaded, neodev = pcall(require, 'neodev')
    if neodev_loaded then
      neodev.setup({})
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
