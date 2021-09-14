local function set (property, value)
    vim.g['prettier#' .. property] = value
end

set('autformat_require_pragma',  false)
set('autoformat_config_present', true)
set('exec_cmd_async',            true)
set('config#tab_width',          4)               -- tab = 4 spaces
set('config#print_width',        'auto')          -- use textwidth
set('config#use_tabs',           'auto')          -- use expandtab
set('config#config_precedence',  'file-override') -- project config file has priority

