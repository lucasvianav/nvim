require("better_escape").setup({
  default = false,
  mappings = {
    i = { -- mode
      j = { -- first key
        k = "<Esc>", -- second key -> action
        j = nil,
      },
    },
    v = {
      j = {
        k = "<Esc>",
        j = nil,
      },
    },
  },
  timeout = 200,
})
