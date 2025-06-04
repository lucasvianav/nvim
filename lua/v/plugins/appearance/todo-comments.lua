local todo_comments = require("todo-comments")

todo_comments.setup({
  signs = false,
  keywords = {
    ALTERNATIVE = { icon = "⎇ ", color = require("v.utils.colors").purple, alt = { "ALT" } },
  },
})

require("v.utils.mappings").set_keybindings({
  {
    "n",
    "[c",
    todo_comments.jump_prev,
  },
  {
    "n",
    "]c",
    todo_comments.jump_next,
  },
  {
    "n",
    "<leader>to",
    "<cmd>TodoTelescope<cr>",
  },
})
