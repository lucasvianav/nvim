local req_submodule = require("v.utils.wrappers").get_require_submodule("v.keybindings")

local M = {
  unmappings = req_submodule("unmappings"),
  general = req_submodule("general"),
  navigation = req_submodule("navigation"),
  win_buf_tab = req_submodule("win-buf-tab"),
}

return M
