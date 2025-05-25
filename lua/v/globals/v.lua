---personal namespace
_G.v = {}

---@type DevEnv
_G.v.env = require('v.utils.env').get_dev_env()

---load local config into global namespace
_G.v.local_config = require("v.local-config").config or {}
