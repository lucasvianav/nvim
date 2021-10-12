-- local map = require('functions').mappings.map

if not packer_plugins or not (packer_plugins['better-escape.vim'] or packer_plugins['better-escape.nvim']) then
    map('i', 'jk', '<Esc>')
end

