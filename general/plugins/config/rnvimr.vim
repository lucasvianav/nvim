" Make Ranger replace netrw and be the file explorer
let g:rnvimr_ex_enable = 0

" Make Ranger to be hidden after picking a file
let g:rnvimr_enable_picker = 1

" Disable a border for floating window
let g:rnvimr_draw_border = 1

" Make Neovim wipe the buffers corresponding to the files deleted by Ranger
let g:rnvimr_enable_bw = 1

" Hide the files included in gitignore
let g:rnvimr_hide_gitignore = 0

" Link CursorLine into RnvimrNormal highlight in the Floating window
highlight link RnvimrNormal CursorLine

" Change the border's color
let g:rnvimr_border_attr = {'fg': 14, 'bg': -1}

" Add a shadow window, value is equal to 100 will disable shadow
let g:rnvimr_shadow_winblend = 50

" Draw border with both
let g:rnvimr_ranger_cmd = 'ranger --cmd="set draw_borders both"'

" Map Rnvimr action
let g:rnvimr_action = {
            \ '<Space>t': 'NvimEdit tabedit',
            \ '<Space>h': 'NvimEdit split',
            \ '<Space>v': 'NvimEdit vsplit',
            \ 'gw': 'JumpNvimCwd',
            \ 'yw': 'EmitRangerCwd'
            \ }

nmap <silent> <space>r :RnvimrToggle<CR>
tnoremap <silent> <space>r <C-\><C-n>:RnvimrToggle<CR>

autocmd Filetype rnvimr tnoremap <buffer><nowait> j j
autocmd Filetype rnvimr tnoremap <buffer><nowait> k k

autocmd Filetype rnvimr nnoremap <buffer><nowait> j j
autocmd Filetype rnvimr nnoremap <buffer><nowait> k k

" autocmd Filetype rnvimr nnoremap <C-h> <nop>
" autocmd Filetype rnvimr nnoremap <C-j> <nop>
" autocmd Filetype rnvimr nnoremap <C-k> <nop>
" autocmd Filetype rnvimr nnoremap <C-l> <nop>
