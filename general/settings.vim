let g:mapleader = "\<Space>"

syntax enable                                   " Enables syntax highlighing
syntax on                                       " Enables syntax highlighing
set    hidden                                   " Enable multiple buffers
set    nowrap                                   " Don't wrap lines
set    encoding=UTF-8                           " The encoding displayed
set    fileencoding=UTF-8                       " The encoding written to file
set    pumheight=10                             " Makes popup menu smaller
set    ruler                                    " Show cursor position
set    iskeyword+=-                             " Dash maintains word text object
set    mouse=a                                  " Enables mouse
set    splitbelow                               " Horizontal splits below
set    splitright                               " Vertical splits to the right
set    t_Co=256                                 " Support 256 colors
set    tabstop=4                                " 4 spaces for a tab
set    shiftwidth=4                             " 4 spaces for indentation
set    smarttab                                 " Makes tabbing smarter
set    expandtab                                " Converts tabs to spaces
set    smartindent                              " Makes indenting smart
set    autoindent                               " Auto indent
set    laststatus=0                             " Always display the status line
set    number                                   " Line numbers
set    relativenumber                           " Relative line numbers
set    cursorline                               " Highlights current line
set    background=dark                          " Background color is dark
set    showtabline=2                            " Always show tab line (top bar)
set    nobackup                                 " This is recommended by coc
set    nowritebackup                            " This is recommended by coc
set    updatetime=300                           " Faster completion
set    formatoptions-=cro                       " No newline continuation of comments
set    clipboard+=unnamedplus                   " System-wide copy-paste
set    scrolloff=1                              " Number of screen lines around cursor
set    nrformats=alpha,octal,hex                " Allows letter sequences
set    path+=**                                 " Enables recursive use of :find
set    wildignore=*/node_modules/*,*/autoload/* " Exclude directories from path
set    inccommand=nosplit                       " Preview :s in real time
set    textwidth=79                             " Break lines after 79 characters (PIP8)
set    colorcolumn=+1                           " Show mark at column 80
set    guifont=DroidSansMono\ Nerd\ Font\ 10    " Symbol font

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
au BufNewFile,BufRead,BufReadPost *.json set syntax=jsonc

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
