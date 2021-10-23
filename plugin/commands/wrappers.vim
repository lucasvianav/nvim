" vim.inspect arguments
command! -nargs=1 P lua require('v.utils.wrappers').inspect(<args>)

" reload current file
command! R lua require('v.utils').reload_or_source_current()
