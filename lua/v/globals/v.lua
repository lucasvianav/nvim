-- TODO: https://github.com/akinsho/dotfiles/blob/main/.config/nvim/lua/as/globals.lua

---personal namespace
_G.v = {}

---@type boolean
_G.v.in_tmux = vim.env.TMUX ~= nil

---@param feat string
---@return boolean
function _G.v.has(feat)
  return vim.fn.has(feat) == 1
end

---@type DevEnv
_G.v.env = require("v.utils.env").get_dev_env()

---load local config into global namespace
_G.v.local_config = require("v.local-config").config or {}

_G.v.plug = {
  is_installed = require("v.lazy.utils").is_installed,
  is_loaded = require("v.lazy.utils").is_loaded,
  load = require("v.lazy.utils").load,
}

_G.v.notify = vim.notify
_G.v.augroup = require("v.utils.autocmds").augroup
