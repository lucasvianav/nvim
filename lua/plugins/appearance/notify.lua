local notify = require('notify')
notify.setup({ stages = 'slide' })

vim.notify = notify
