local snacks = require("snacks")

local enabled = { enabled = true }
local disabled = { enabled = false }

snacks.setup({
  bigfile = disabled,
  dashboard = disabled,
  debug = enabled,
  dim = disabled,
  explorer = disabled,
  git = disabled,
  gitbrowse = disabled,
  image = disabled, -- TODO
  indent = disabled,
  input = {
    enabled = true,
    prompt_pos = "left",
    icon = "󰙏 ",
    win = {
      relative = "cursor",
      style = "input",
      border = "rounded",
      backdrop = {
        transparent = true,
        blend = 80,
      },
      keys = {
        n_crtl_c = { "<c-c>", { "cmp_close", "cancel" }, mode = "n", expr = true },
        i_crtl_c = { "<c-c>", { "cmp_close", "cancel" }, mode = "i", expr = true },
      },
    },
    expand = false,
  },
  layout = enabled,
  lazygit = disabled,
  notifier = disabled, -- TODO
  notify = disabled,
  picker = {
    enabled = true,
    ui_select = true,
    win = {
      input = {
        keys = {
          ["<Esc>"] = { "close", mode = { "n", "i" } },
          ["<c-c>"] = { "close", mode = { "n", "i" } },
        },
      },
    },
  },
  profiler = disabled, -- TODO
  quickfile = enabled,
  rename = enabled,
  scope = disabled,
  scratch = disabled,
  scroll = disabled,
  statuscolumn = disabled,
  terminal = disabled,
  toggle = disabled,
  util = disabled,
  win = enabled,
  words = disabled,
  zen = {
    enabled = true,
    win = {
      style = "zen",
      width = 140,
      backdrop = {
        transparent = true,
        blend = 20,
      },
    },
  },
})

_G.st = function()
  snacks.debug.backtrace()
end

-- require('dressing').setup({
--   input = {
--     enabled = true,
--     default_prompt = '~ input ~',
--     prompt_align = 'left',
--     insert_only = false,
--     border = 'rounded',
--     relative = 'cursor',
--     win_options = {
--       winblend = 4,
--     },
--   },

--   select = {
--     enabled = true,
--     backend = { 'telescope', 'builtin' },
--     telescope = require('telescope.themes').get_cursor({}),
--     builtin = {
--       border = 'rounded',
--       relative = 'editor',
--       win_options = {
--         winblend = 10,
--       },
--     },
--   },
-- })
