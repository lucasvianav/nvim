augroup LocalConfig
    au!
    au BufEnter <buffer> lua require('v.utils').source_local_config()
augroup END
