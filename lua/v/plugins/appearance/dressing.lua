require('dressing').setup({
  input = {
    enabled = true,
    default_prompt = '~ input ~',
    prompt_align = 'left',
    insert_only = false,
    border = 'rounded',
    relative = 'cursor',
    winblend = 4,
  },

  select = {
    enabled = true,
    backend = { 'telescope', 'builtin' },
    telescope = require('telescope.themes').get_cursor({}),
    builtin = {
      border = 'rounded',
      relative = 'editor',
      winblend = 10,
    },
  },
})
