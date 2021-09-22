local npairs = require('nvim-autopairs')

npairs.setup({
    disable_filetype          = { 'TelescopePrompt' },
    ignored_next_char         = string.gsub([[ [%w%%%'%[%'%.] ]],'%s+', ''),
    enable_moveright          = true,
    enable_afterquote         = true,  -- add bracket pairs after quote
    enable_check_bracket_line = true,  -- check bracket in same line
    check_ts                  = true,
    map_bs                    = false, -- <BS>
})
npairs.add_rules(require('nvim-autopairs.rules.endwise-lua'))

map('i', '<CR>', 'v:lua.CR()', { expr = true })
map('i', '<BS>', 'v:lua.BS()', { expr = true })

