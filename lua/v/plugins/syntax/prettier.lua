require('v.utils').set_viml_options('prettier#', {
    autformat_require_pragma     = false,
    autoformat_config_present    = true,
    exec_cmd_async               = true,
    ['config#tab_width']         = 4,               -- tab = 4 spaces
    ['config#print_width']       = 'auto',          -- use textwidth
    ['config#use_tabs']          = 'auto',          -- use expandtab
    ['config#config_precedence'] = 'file-override', -- project config file has priority
})
