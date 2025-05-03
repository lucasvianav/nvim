-- update lightbulb whenever cursor stops
require('v.utils.autocmds').augroup('LspLightbulb', {
  {
    event = { 'CursorHold', 'CursorHoldI' },
    opts = {
      pattern = '*',
      callback = function()
        local loaded, lightbulb = pcall(require, 'nvim-lightbulb')

        if not loaded then
          return
        end

        lightbulb.update_lightbulb({
          priority = 10,
          hide_in_unfocused_buffer = true,
          action_kinds = nil,
        })
      end,
    },
  },
})
