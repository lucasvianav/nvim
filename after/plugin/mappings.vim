" Mappings to substitute actual multiple cursor
"
" SOURCES:
" http://www.kevinli.co/posts/2017-01-19-multiple-cursors-in-500-bytes-of-vimscript/
" https://www.youtube.com/watch?v=YwMgnmZNWXA
" https://www.youtube.com/watch?v=7Bx_mLDBtRc
" https://github.com/wincent/scalpel
"
" I do like multiple cursors and I wish Vim/Neovim had them natively. I
" tried `mg979/vim-visual-multi` and it didn't work great for me, So I'm
" using this instead.
"
" KEYBINDINGS:
" cn: change word forwards
" cN: change word backwards
" cq: play macro on word forwards
" cQ: play macro on word backwards
" <leader>s: change word in the whole buffer

let g:mc = "\"zy/\\V\<C-r>=escape(@z, '/')\<CR>\<CR>"

nnoremap cn *``"_cgn
nnoremap cN *``"_cgN

vnoremap <expr> cn g:mc . '``"_cgn'
vnoremap <expr> cN g:mc . '``"_cgN'

function! SetupCR()
  nnoremap <Enter> :nnoremap <lt>Enter> n@z<CR>q:<C-u>let @z=strpart(@z,0,strlen(@z)-1)<CR>n@z
endfunction

nnoremap cq :call SetupCR()<CR>*``qz
nnoremap cQ :call SetupCR()<CR>#``qz

vnoremap <expr> cq ":\<C-u>call SetupCR()\<CR>" . "gv" . g:mc . "``qz"
vnoremap <expr> cQ ":\<C-u>call SetupCR()\<CR>" . "gv" . substitute(g:mc, '/', '?', 'g') . "``qz"

nnoremap <leader>s :%s/\<<c-r><c-w>\>//gI<left><left><left>

