---personal namespace
_G.v = {}

---@type boolean
_G.v.in_tmux = vim.env.TMUX ~= nil

---@type DevEnv
_G.v.env = require("v.utils.env").get_dev_env()

---load local config into global namespace
_G.v.local_config = require("v.local-config").config or {}
