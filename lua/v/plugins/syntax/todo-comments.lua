local todo_comments = require('todo-comments')

todo_comments.setup({ signs = false })

require('v.utils.mappings').set_keybindings({
  {
    'n',
    '[c',
    todo_comments.jump_prev,
  },
  {
    'n',
    ']c',
    todo_comments.jump_next,
  },
  {
    'n',
    '<leader>fc',
    '<cmd>TodoTelescope<cr>',
  },
})
