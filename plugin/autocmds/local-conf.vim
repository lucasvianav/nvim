augroup LocalConfig
    au!
    au BufEnter <buffer> lua source_local_config()
augroup END
