local alt
require("v.utils.autocmds").augroup("LoadOilOnDirOpen", {
  {
    event = "BufEnter",
    opts = {
      pattern = "*",
      desc = "Load Oil if trying to open a directory with Netrw",
      callback = function(event)
        local bufnr = vim.api.nvim_get_current_buf()
        vim.schedule(function()
          if v.plug.is_loaded("oil.nvim") then
            pcall(vim.api.nvim_del_augroup_by_name, "LoadOilOnDirOpen")
            return
          end

          local is_dir = require("v.utils.paths").dir_exists(event.match)

          if not is_dir then
            if #event.match > 0 then
              alt = event.match
            elseif #(alt or "") == 0 then
              alt = vim.fn.getreg("#")
              alt = #alt > 0 and alt or nil
            end
            return
          end

          vim.api.nvim_set_option_value("bufhidden", "wipe", { buf = bufnr })
          require("oil").open(event.match, {}, function()
            if alt and #alt > 0 then
              vim.fn.setreg("#", alt)
            end
            vim.cmd.clearjumps()
            vim.api.nvim_buf_delete(bufnr, { force = true })
          end)
        end)
      end,
    },
  },
})
