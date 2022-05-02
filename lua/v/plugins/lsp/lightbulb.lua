-- update lightbulb whenever cursor stops
require('v.utils.autocmds').augroup('LspLightbulb', {
  {
    event = { 'CursorHold', 'CursorHoldI' },
    opts = {
      pattern = '*',
      callback = function()
        require('nvim-lightbulb').update_lightbulb()
      end,
    },
  },
})
