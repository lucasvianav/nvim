let g:mapleader = "\<Space>"

syntax enable                                " Enables syntax highlighing
syntax on                                    " Enables syntax highlighing
set    hidden                                " Required to keep multiple buffers open multiple buffers
set    nowrap                                " Display long lines as just one line
set    encoding=UTF-8                        " The encoding displayed
set    pumheight=10                          " Makes popup menu smaller
set    fileencoding=UTF-8                    " The encoding written to file
set    ruler                                 " Show the cursor position all the time
set    cmdheight=2                           " More space for displaying messages
set    iskeyword+=-                          " treat dash separated words as a word text object"
set    mouse=a                               " Enable your mouse
set    splitbelow                            " Horizontal splits will automatically be below
set    splitright                            " Vertical splits will automatically be to the right
set    t_Co=256                              " Support 256 colors
set    conceallevel=0                        " So that I can see `` in markdown files
set    tabstop=4                             " Insert 4 spaces for a tab
set    shiftwidth=4                          " Change the number of space characters inserted for indentation
set    smarttab                              " Makes tabbing smarter will realize you have 2 vs 4
set    expandtab                             " Converts tabs to spaces
set    smartindent                           " Makes indenting smart
set    autoindent                            " Good auto indent
set    laststatus=0                          " Always display the status line
set    number                                " Line numbers
set    relativenumber                        " Line numbers relative to current line
set    cursorline                            " Enable highlighting of the current line
set    background=dark                       " tell vim what the background color looks like
set    showtabline=4                         " Always show tabs
set    nobackup                              " This is recommended by coc
set    nowritebackup                         " This is recommended by coc
set    updatetime=300                        " Faster completion
set    timeoutlen=500                        " By default timeoutlen is 1000 ms
set    formatoptions-=cro                    " Stop newline continution of comments
set    clipboard+=unnamedplus                " Copy paste between vim and everything else
set    scrolloff=1                           " Minimal number of screen lines to keep above and below the cursor.
set    nrformats=alpha,octal,hex             " Allow letter sequences
set    guifont=DroidSansMono\ Nerd\ Font\ 10 " Symbol font
set    inccommand=nosplit                    " Preview substitutions (:s) in real time
set    cmdheight=1                           " Makes command line shorter

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
