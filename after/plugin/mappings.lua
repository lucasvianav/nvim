local map       = require('v.utils.mappings').map
local installed = require('v.utils.packer').is_plugin_installed

if not (installed('better-escape.vim') or installed('better-escape.nvim')) then
    map('i', 'jk', '<Esc>')
end

