-- TODO: https://github.com/akinsho/dotfiles/blob/main/.config/nvim/lua/as/globals.lua

---personal namespace
_G.v = {}

---@type boolean
_G.v.in_tmux = vim.env.TMUX ~= nil

---@type DevEnv
_G.v.env = require("v.utils.env").get_dev_env()

---load local config into global namespace
_G.v.local_config = require("v.local-config").config or {}

_G.v.plug = {
  is_installed = require("v.lazy.utils").is_installed,
  is_loaded = require("v.lazy.utils").is_loaded,
  load = require("v.lazy.utils").load,
}
