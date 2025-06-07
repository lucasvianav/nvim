require("better_escape").setup({
  default_mappings = false,
  mappings = {
    i = { -- mode
      j = { -- first key
        k = "<Esc>", -- second key -> action
      },
    },
  },
  timeout = 200,
})
