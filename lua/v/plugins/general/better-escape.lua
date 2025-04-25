require('better_escape').setup({
  default = false,
  mappings = {
    i = { -- mode
      i = { -- first key
        j = '<Esc>', -- second key -> action
      },
    },
    v = {
      i = {
        j = '<Esc>',
      },
    },
  },
  timeout = 200,
})
