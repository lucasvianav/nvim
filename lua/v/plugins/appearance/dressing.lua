require('dressing').setup({
  input = {
    enabled = true,
    default_prompt = '~ input ~',
    prompt_align = 'left',
    insert_only = false,
    border = 'rounded',
    relative = 'cursor',
    win_options = {
      winblend = 4,
    },
  },

  select = {
    enabled = true,
    backend = { 'telescope', 'builtin' },
    telescope = require('telescope.themes').get_cursor({}),
    builtin = {
      border = 'rounded',
      relative = 'editor',
      win_options = {
        winblend = 10,
      },
    },
  },
})
