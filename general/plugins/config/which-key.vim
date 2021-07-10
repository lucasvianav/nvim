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
let g:which_key_map.a        = [ '<Plug>(EasyAlign)'             , 'auto align'              ]
let g:which_key_map.b        = [ ':Buffers'                      , 'list buffers'            ]
let g:which_key_map.c        = [ '<Plug>(easymotion-overwin-f)'  , 'go to char'              ]
let g:which_key_map.d        = [ ':<C-u>CocList diagnostics<cr>' , 'show all diagnostics'    ]
let g:which_key_map.e        = [ ':CocCommand explorer'          , 'explorer'                ]
let g:which_key_map.f        = [ ':FZF'                          , 'search files'            ]
let g:which_key_map.F        = [ '<Plug>(coc-format-selected)'   , 'format selection'        ]
let g:which_key_map.h        = [ '<C-W>s'                        , 'split below'             ]
let g:which_key_map.n        = [ ':noh'                          , 'hide highlights'         ]
let g:which_key_map.q        = [ ':BufClose'                     , 'close buffer'            ]
let g:which_key_map.r        = [ ':RnvimrToggle'                 , 'ranger'                  ]
let g:which_key_map.s        = [ '<Plug>(Scalpel)'               , 'scalpel'                 ]
let g:which_key_map.S        = [ ':Startify'                     , 'start screen'            ]
" let g:which_key_map.t        = [ ':ToggleTermBottom'             , 'open terminal below'     ]
let g:which_key_map.v        = [ '<C-W>v'                        , 'split right'             ]
let g:which_key_map.w        = [ '<Plug>(easymotion-overwin-w)'  , 'go to word'              ]
let g:which_key_map['/']     = [ ':Rg'                           , 'search text'             ]
let g:which_key_map['rn']    = [ '<Plug>(coc-rename)'            , 'rename symbol'           ]
let g:which_key_map['sy']    = [ '<Plug>(easymotion-overwin-f2)' , 'go to syllab'            ]
" let g:which_key_map['tr']    = [ ':ToggleTermRight'              , 'open terminal right'     ]
let g:which_key_map['wq']    = [ ':BcWrite'                      , 'saves and closes buffer' ]
let g:which_key_map['<Tab>'] = [ '<C-^>'                         , 'toggle buffer'           ]

nnoremap <silent> <Leader>q :BufClose<CR>
nnoremap <silent> <Leader>wq :BqWrite<CR>

" Unlisted keymaps
let g:which_key_map.O     = 'which_key_ignore'
let g:which_key_map.o     = 'which_key_ignore'
let g:which_key_map.p     = 'which_key_ignore'
let g:which_key_map.P     = 'which_key_ignore'
let g:which_key_map['cf'] = 'which_key_ignore'

let g:which_key_map['?'] = {
    \ 'name' : '+ search'   ,
    \ 'c'    : [':Commands' , 'all commands'],
    \ 'ch'   : [':History:' , 'command history'],
    \ '/'    : [':BLines'   , 'current buffer'],
    \ 'h'    : [':History'  , 'file history'],
    \ 's'    : [':Snippets' , 'snippets'],
    \ 'w'    : [':Windows'  , 'search windows'],
    \ }

let g:which_key_map['!'] = {
    \ 'name' : '+ settings'  ,
    \ 'c'    : [':Colors'    , 'color schemes'],
    \ 't'    : [':Filetypes' , 'file types'],
    \ }

let g:which_key_map.g = {
    \ 'name' : '+ git'         ,
    \ 'c'    : [':Commits'     , 'commits'],
    \ 'bc'   : [':BCommits'    , 'buffer commits'],
    \ 'f'    : [':GFiles'      , 'git files'],
    \ 'mf'   : [':GFiles?'     , 'modified git files'],
    \ 'd'    : [':Gvdiff!'     , 'merge conflict comparison'],
    \ 'h'    : [':diffget //2' , 'merge from target branch (left)'],
    \ 'l'    : [':diffget //3' , 'merge from merge branch (right)'],
    \ }

let g:which_key_map.t = {
            \ 'name' : '+ tmux',
            \ 'p':  [  ':VimuxPromptCommand'       , 'prompt for command'   ] ,
            \ 'r':  [  ':VimuxRunLastCommand'      , 'repeats last command' ] ,
            \ 'i':  [  ':VimuxInspectRunner'       , 'inspect runner page'  ] ,
            \ 'z':  [  ':VimuxZoomRunner'          , 'zooom tmux pane'      ] ,
            \ 'c':  [  ':VimuxClearScreenHistory'  , 'clear tmux pane'      ] ,
            \ 't':  [  ':VimuxTogglePane'          , 'toggle tmux pane'     ] ,
            \ }


" Register which key map
call which_key#register('<Space>', "g:which_key_map")
