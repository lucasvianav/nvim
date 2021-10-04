" vim.inspect arguments
command! -nargs=1 P lua inspect(<args>)
command! -nargs=1 Inspect lua inspect(<args>)

" reload current file
command! R lua R(get_current_require_path())
