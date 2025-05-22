require("v.utils.mappings").map({ "n", "<Leader>r", "<CMD>RnvimrToggle<CR>" })

require("v.utils").set_viml_options("dashboard", {
  enable_ex = 1, -- replace netrw
  enable_picker = 1, -- hide after picking file

  action = {
    ["<C-t>"] = "NvimEdit tabedit",
    ["<C-x>"] = "NvimEdit split",
    ["<C-h>"] = "NvimEdit split",
    ["<C-v>"] = "NvimEdit vsplit",
    gw = "JumpNvimCwd",
    yw = "EmitRangerCwd",
  },
})
