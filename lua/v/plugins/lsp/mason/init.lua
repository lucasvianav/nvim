local mason_registry = require("mason-registry")
local packages = require("v.lsp.packages")
local utils = require("v.lsp")

local servers = packages.in_env(packages.servers)
local formatters = packages.in_env(packages.formatters)
local lockfile = require("v.plugins.lsp.mason.lock").get_lockfile()

require("mason").setup()
require("v.plugins.lsp.mason.lock").setup()
require("mason-lspconfig").setup({
  ensure_installed = vim.tbl_map(function(pkg)
    local version = lockfile[pkg]
    return version and (pkg .. "@" .. version) or pkg
  end, servers),
  automatic_enable = false,
})

-- setup lsp servers
for _, server in ipairs(servers) do
  local config = utils.make_config()
  local has_custom_config, custom_config = pcall(require, "v.lsp.servers." .. server)

  if custom_config.skip_lsp_setup then
    goto continue
  end

  if has_custom_config and custom_config and custom_config.config then
    config = vim.tbl_deep_extend("force", config, custom_config.config)
  end

  if custom_config.legacy_config then
    require("lspconfig")[server].setup(config)
    goto continue
  end

  vim.lsp.config(server, config)
  vim.lsp.enable(server)

  ::continue::
end

-- install formatters
for _, it in ipairs(formatters) do
  local pkg = mason_registry.get_package(it)

  if pkg:is_installed() then
    goto continue
  end

  pkg:install(
    { version = lockfile[pkg.name] },
    vim.schedule_wrap(function(success, err)
      if success then
        vim.notify(
          ("%s was successfully installed"):format(it),
          vim.log.levels.INFO,
          { title = "mason.nvim" }
        )
      else
        vim.notify(
          ("Failed to install %s. Installation logs are available in :Mason and :MasonLog"):format(
            it
          ),
          vim.log.levels.ERROR,
          { title = "mason.nvim" }
        )
        P(err)
      end
    end)
  )

  ::continue::
end
