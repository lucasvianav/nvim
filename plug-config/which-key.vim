" Map <Space> to which_key
if exists('g:vscode')
  nnoremap <silent> <leader> :call VSCodeNotify("whichkey.show")<CR>
else
  nnoremap <silent> <leader> :silent WhichKey '<Space>'<CR>
  vnoremap <silent> <leader> :silent <c-u> :silent WhichKeyVisual '<Space>'<CR>
endif

" Create map to add keys to
let g:which_key_map =  {}
" Define a separator
let g:which_key_sep = '→'
" set timeoutlen=100

" Not a fan of floating windows for this
let g:which_key_use_floating_win = 0
let g:which_key__centered = 1

" Change the colors if you want
highlight default link WhichKey             Operator
highlight default link WhichKeySeperator    DiffAdded
highlight default link WhichKeyGroup        Identifier
highlight default link WhichKeyDesc         Function

" Hide status line
autocmd! FileType which_key
autocmd  FileType which_key set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 noshowmode ruler

" Single mappings
let g:which_key_map.e = [ ':CocCommand explorer'       , 'explorer' ]
let g:which_key_map.f = [ ':Files'                     , 'search files' ]
let g:which_key_map.F = [ '<Plug>(coc-format-selected)'                     , 'format selection' ]
let g:which_key_map.h = [ '<C-W>s'                     , 'split below']
let g:which_key_map.r = [ ':Ranger'                    , 'ranger' ]
let g:which_key_map.S = [ ':Startify'                  , 'start screen' ]
let g:which_key_map['/'] = [ ':Rg'                        , 'search text' ]
let g:which_key_map.b = [ ':Buffers'                        , 'list buffers' ]
let g:which_key_map.v = [ '<C-W>v'                     , 'split right']
let g:which_key_map.w = [ '<Plug>(easymotion-overwin-w)'                     , 'go to word']
let g:which_key_map.c = [ '<Plug>(easymotion-overwin-f)'                     , 'go to char']
let g:which_key_map['ss'] = [ '<Plug>(easymotion-overwin-f2)'                     , 'go to syllab']


" Unlisted keymaps
let g:which_key_map.O = 'which_key_ignore'
let g:which_key_map.o = 'which_key_ignore'
let g:which_key_map.n = 'which_key_ignore'
let g:which_key_map.p = 'which_key_ignore'
let g:which_key_map.P = 'which_key_ignore'
let g:which_key_map['cf'] = 'which_key_ignore'

" s is for search
let g:which_key_map.s = {
      \ 'name' : '+ search' ,
      \ '/' : [':History/'     , 'history'],
      \ ';' : [':Commands'     , 'commands'],
      \ 'a' : [':Ag'           , 'text Ag'],
      \ 'b' : [':BLines'       , 'current buffer'],
      \ 'B' : [':Buffers'      , 'open buffers'],
      \ 'c' : [':Commits'      , 'commits'],
      \ 'C' : [':BCommits'     , 'buffer commits'],
      \ 'f' : [':Files'        , 'files'],
      \ 'g' : [':GFiles'       , 'git files'],
      \ 'G' : [':GFiles?'      , 'modified git files'],
      \ 'h' : [':History'      , 'file history'],
      \ 'H' : [':History:'     , 'command history'],
      \ 'l' : [':Lines'        , 'lines'] ,
      \ 'm' : [':Marks'        , 'marks'] ,
      \ 'M' : [':Maps'         , 'normal maps'] ,
      \ 'p' : [':Helptags'     , 'help tags'] ,
      \ 'P' : [':Tags'         , 'project tags'],
      \ 's' : [':Snippets'     , 'snippets'],
      \ 'S' : [':Colors'       , 'color schemes'],
      \ 't' : [':Rg'           , 'text Rg'],
      \ 'T' : [':BTags'        , 'buffer tags'],
      \ 'w' : [':Windows'      , 'search windows'],
      \ 'y' : [':Filetypes'    , 'file types'],
      \ 'z' : [':FZF'          , 'FZF'],
      \ }

" Register which key map
call which_key#register('<Space>', "g:which_key_map")
