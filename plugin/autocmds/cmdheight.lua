-- local cmdheight = require("v.settings").appearance.cmdheight
v.augroup("FixCmdHeight", {
  {
    event = "VimEnter",
    opts = {
      -- auto-sessions#64, neovim#11330
      desc = "Fix Neovim height after start (so cmdheight isn't huge)",
      callback = function()
        ---@diagnostic disable-next-line: undefined-field
        local pid, WINCH = (vim.uv.getpid() or vim.fn.getpid()), (vim.uv.constants or {}).SIGWINCH
        vim.defer_fn(function()
          if WINCH then
            vim.uv.kill(pid, WINCH)
          else
            vim.api.nvim_exec2("silent! !kill -s SIGWINCH " .. pid, { output = false })
          end
        end, 30)
      end,
    },
  },
  -- {
  --   event = "VimResized",
  --   opts = {
  --     -- auto-sessions#64, neovim#11330
  --     desc = "Fix Neovim cmdheight",
  --     callback = function()
  --       vim.schedule(function()
  --         vim.opt.cmdheight = cmdheight
  --       end)
  --     end,
  --   },
  -- },
})
