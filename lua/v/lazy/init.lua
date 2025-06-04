local utils = require("v.lazy.utils")

utils.ensure_installed()

---@diagnostic disable-next-line: missing-fields
require("lazy").setup({
  root = utils.paths.plugins,
  defaults = { lazy = false },
  spec = {
    { import = "v.themes.init" },
    { import = "v.plugins" },
  },
  local_spec = false,
  lockfile = vim.fs.joinpath(vim.fn.stdpath("config"), "lazy-lock.json"),
  pkg = {
    enabled = true,
    cache = utils.paths.cache,
    sources = {
      "lazy",
      "rockspec",
      "packspec",
    },
  },
  ---@diagnostic disable-next-line: assign-type-mismatch
  dev = {
    path = "~/github/nvim",
    fallback = true,
  },
  install = {
    missing = true,
    colorscheme = {},
  },
  ui = {
    ---@type { [string]: { [1]: fun(plugin: LazyPlugin), desc: string } }
    custom_keys = {
      ["g?"] = {
        function(plugin)
          require("lazy.util").notify(vim.inspect(plugin), {
            title = "Inspect " .. plugin.name,
            lang = "lua",
          })
        end,
        desc = "Inspect Plugin",
      },
      ["yp"] = {
        function(plugin)
          require("v.utils.clipboard").copy(plugin.dir)
        end,
        desc = "Yank plugin path",
      },
      ["yn"] = {
        function(plugin)
          require("v.utils.clipboard").copy(plugin.name)
        end,
        desc = "Yank plugin name",
      },

      -- TODO: open tmux window in plugin dir
      -- ["<leader>t"] = {
      --   function(plugin)
      --     require("lazy.util").float_term(nil, {
      --       cwd = plugin.dir,
      --     })
      --   end,
      --   desc = "Open terminal in plugin dir",
      -- },
    },
  },
  diff = {
    cmd = "diffview.nvim",
  },
  checker = {
    enabled = true,
    frequency = 3600 * 3,
    check_pinned = false,
  },
  --- automatically check for config file changes and reload the ui
  change_detection = {
    enabled = true,
    notify = true,
  },
  performance = {
    cache = {
      enabled = true,
    },
    reset_packpath = true, --- reset the package path to improve startup time
    rtp = {
      reset = true,        --- reset the runtime path to $VIMRUNTIME and your config directory
      paths = {}, ---@type string[] custom paths to include in the rtp
      disabled_plugins = {}, ---@type string[]
    },
  },
  readme = {
    enabled = true,
    root = vim.fs.joinpath(vim.fn.stdpath("state"), "lazy", "readme"),
    files = { "README.md", "lua/**/README.md" },
    skip_if_doc_exists = true,
  },
  state = utils.paths.state,
  profiling = {
    loader = false,
    require = false,
  },
  debug = false,
})
