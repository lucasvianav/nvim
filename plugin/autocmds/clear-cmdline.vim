augroup ClearCommandline
    au!
    au CmdlineLeave : lua require('v.utils.commands').clear_cmdline()()
    au CmdlineChanged : lua require('v.utils.commands').clear_cmdline()()
augroup END
