-- ALT: https://github.com/AckslD/messages.nvim

vim.api.nvim_create_user_command("M", function(args)
  local default = ("%smessages"):format(args.count > 0 and tostring(args.count) or "")
  D(vim.api.nvim_exec2(args.args:take_if_not_blank() or default, { output = true }).output)
end, { nargs = "?", complete = "command", count = true })

vim.api.nvim_create_user_command("D", "lua D(<args>)", {
  nargs = "+",
  complete = "lua",
})
