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
    function()
      local snacks_picker = require("snacks").picker["todo_comments"]
      if snacks_picker then
        snacks_picker({ keywords = { "TODO", "FIX", "FIXME" } })
      else
        vim.api.nvim_exec2("TodoTelescope", { output = false })
      end
    end,
  },
})
