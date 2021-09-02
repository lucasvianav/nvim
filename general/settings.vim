let g:mapleader = "\<Space>"

syntax enable " enables syntax highlighing
syntax on     " enables syntax highlighing

set hidden                                   " enable multiple buffers
set nowrap                                   " don't wrap lines
set encoding=UTF-8                           " the encoding displayed
set fileencoding=UTF-8                       " the encoding written to file
set pumheight=10                             " makes popup menu smaller
set ruler                                    " show cursor position
set mouse=a                                  " enables mouse
set splitbelow                               " horizontal splits below
set splitright                               " vertical splits to the right
set tabstop=4                                " 4 spaces for a tab
set shiftwidth=4                             " 4 spaces for indentation
set smarttab                                 " makes tabbing smarter
set expandtab                                " converts tabs to spaces
set smartindent                              " makes indenting smart
set autoindent                               " auto indent
set laststatus=0                             " always display the status line
set number                                   " line numbers
set relativenumber                           " relative line numbers
set cursorline                               " highlights current line
set background=dark                          " background color is dark
set showtabline=2                            " always show tab line (top bar)
set nobackup                                 " don't backup files before overwriting them
set nowritebackup                            " don't backup files before overwriting them
set updatetime=300                           " faster completion
set formatoptions-=ro                        " no newline continuation of comments
set formatoptions+=tcjnl                     " better formatting options (:help it)
set clipboard+=unnamedplus                   " system-wide copy-paste
set scrolloff=1                              " number of screen lines around cursor
set sidescrolloff=5                          " number of screen columns around cursor
set nrformats=alpha                          " allows letter sequences
set path+=**                                 " enables recursive use of :find
set wildignore=*/node_modules/*,*/autoload/* " exclude directories from path
set inccommand=nosplit                       " preview :s in real time
set textwidth=79                             " break lines after 79 characters (pip8)
set colorcolumn=+1                           " show mark at column 80
set synmaxcol=240                            " stop syntax highlighting after 500 chars

" if folding is enabled
if has('folding')
    if has('windows')
        set fillchars=vert:┃            " BOX DRAWINGS HEAVY VERTICAL (U+2503, UTF-8: E2 94 83)
    endif

    set foldmethod=indent               " not as cool as syntax, but faster
    autocmd VimEnter,VimLeave * bufdo set foldlevel=0
    autocmd BufAdd,Bufnew <afile> set foldlevel=0
    " set foldlevelstart=0                " start folded
endif

" auto source when writing to init.vm alternatively you can run :source $MYVIMRC
au! BufWritePost $MYVIMRC source %

" enable commentaries in json
autocmd BufEnter *.json setlocal filetype=jsonc

" Make macros work better in visual mode
xnoremap @ :<C-u>call ExecuteMacroOverVisualRange()<CR>
function! ExecuteMacroOverVisualRange()
    echo "@".getcmdline()
    execute ":'<,'>normal @".nr2char(getchar())
endfunction

" Handle trailing whitespaces
set list listchars=trail:.,extends:>
function! <SID>StripTrailingWhitespaces()
    if !&binary && &filetype != 'diff'
        let l:save = winsaveview()
        keeppatterns %s/\s\+$//e
        call winrestview(l:save)
    endif
endfun
autocmd FileType c,cpp,java,php,ruby,python,javascript,typescript,vim,sh,markdown autocmd BufWritePre <buffer> :call <SID>StripTrailingWhitespaces()

function! s:SourceLocalConfig() abort
    let l:cwd = getcwd()

    if !empty($WORK_DIR) && cwd =~# '^' . escape($WORK_DIR, '.')
        source l:cwd . '/.nvimrc'
    endif
endfunction

autocmd BufEnter <buffer> silent! :call <SID>SourceLocalConfig()

