local utils = require("v.lazy.utils")

utils.ensure_installed()

require("lazy").setup({
  root = utils.paths.plugins,
  defaults = {
    lazy = false, -- lazy load everything by default
  },
  spec = {
    { import = "v.themes.init" },
    { import = "v.plugins" },
  },
  local_spec = true,
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
  rocks = {
    enabled = true,
    root = utils.paths.rocks,
  },
  dev = {
    path = "~/github/nvim",
    ---@type string[] plugins that match these patterns will use your local versions instead of being fetched from GitHub
    patterns = {},
    fallback = true,
  },
  install = {
    missing = true,
    colorscheme = {},
  },
  ui = {
    custom_keys = {
      ["<localleader>l"] = {
        function(plugin)
          require("lazy.util").float_term({ "lazygit", "log" }, {
            cwd = plugin.dir,
          })
        end,
        desc = "Open lazygit log",
      },

      ["<localleader>i"] = {
        function(plugin)
          require("lazy.util").notify(vim.inspect(plugin), {
            title = "Inspect " .. plugin.name,
            lang = "lua",
          })
        end,
        desc = "Inspect Plugin",
      },

      ["<localleader>t"] = {
        function(plugin)
          require("lazy.util").float_term(nil, {
            cwd = plugin.dir,
          })
        end,
        desc = "Open terminal in plugin dir",
      },
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
})
