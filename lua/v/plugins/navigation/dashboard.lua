local pad = require('v.utils').pad_string_right
local db = require('dashboard')

db.custom_header = require('v.utils.ascii').neovim_3
db.custom_center = {
  {
    icon = pad('', 5),
    desc = pad('Find File', 40),
    shortcut = 'SPC f f',
    action = 'Telescope find_files',
  },
  {
    icon = pad('', 5),
    desc = pad('Grep', 40),
    shortcut = 'SPC f p',
    action = 'Telescope live_grep',
  },
  {
    icon = pad('', 5),
    desc = pad('New File', 40),
    shortcut = 'CMD ene',
    action = 'DashboardNewFile',
  },
  {
    icon = pad('', 5),
    desc = pad('Navigate Dotfiles', 40),
    shortcut = 'SPC f d',
    action = function()
      require('v.utils.telescope').find_dotfiles()
    end,
  },
  {
    icon = pad('', 5),
    desc = pad('Navigate Neovim Settings', 40),
    shortcut = 'SPC f n',
    action = function()
      require('v.utils.telescope').find_nvim()
    end,
  },
}
db.custom_footer = { '      ' }

db.hide_statusline = true
db.hide_tabline = true
