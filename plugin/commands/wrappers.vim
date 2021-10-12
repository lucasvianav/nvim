" vim.inspect arguments
command! -nargs=1 P lua require('functions').wrappers.inspect(<args>)

" reload current file
command! R lua reload_or_source_current()
