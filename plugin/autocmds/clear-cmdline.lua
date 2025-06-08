---@source http://unix.stackexchange.com/a/613645

local timer = vim.uv.new_timer()
v.augroup("ClearCommandline", {
  {
    event = { "CmdlineLeave", "CmdlineChanged" },
    opts = {
      callback = function()
        timer = timer or vim.uv.new_timer()
        if not timer then
          return
        end

        timer:stop()
        timer:start(5000, 0, function()
          if vim.api.nvim_get_mode().mode == "n" then
            vim.schedule(vim.schedule_wrap(function()
              vim.api.nvim_exec2("echon ''", { output = false })
            end))
          end
        end)
      end,
    },
  },
})
