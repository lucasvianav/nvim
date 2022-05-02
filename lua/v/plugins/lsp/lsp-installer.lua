local utils = require('v.utils.lsp')

require('nvim-lsp-installer').setup({
  ensure_installed = utils.servers,
  automatic_installation = true,
})

for _, server in ipairs(utils.servers) do
  local config = utils.make_config()

  local custom_config_path = 'v.plugins.lsp.servers.' .. server
  local has_custom_config, custom_config = pcall(require, custom_config_path)

  if has_custom_config then
    config = vim.tbl_deep_extend('force', config, custom_config)
  end

  if server == 'sumneko_lua' then
    local is_packer_loaded, packer = require('v.utils.packer').get_packer()
    if is_packer_loaded then
      packer.loader('lua-dev')
    end

    local luadev_loaded, luadev = pcall(require, 'lua-dev')
    if luadev_loaded then
      config = luadev.setup({ lspconfig = config })
    end
  end

  require('lspconfig')[server].setup(config)
end
