local neck = require("no-neck-pain")

neck.setup({
  disableOnLastBuffer = true,
  fallbackOnBufferDelete = false,
  buffers = {
    setNames = true,
    right = {
      enabled = false,
    },
  },
  autocmds = {
    skipEnteringNoNeckPainBuffer = false,
  },
})

require("v.utils.mappings").map({ "n", "<leader>nn", neck.toggle, desc = "Center buffer" })
