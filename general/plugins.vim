" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  "autocmd VimEnter * PlugInstall
  "autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/autoload/plugged')

    " Which Key
    Plug 'liuchengxu/vim-which-key'
    " Quickscope
    Plug 'unblevable/quick-scope'
    " Press CTRL + / to comment
    Plug 'tpope/vim-commentary'
    " Perl Regex
    Plug 'othree/eregex.vim'
    " Better Unicode Compatibility?
    Plug 'tpope/vim-characterize'
    " Enables . repeat for Plug-In maps
    Plug 'tpope/vim-repeat'
    " Fixes <C-A> and <C-X> for dates
    Plug 'tpope/vim-speeddating'
    " Better clipboard
    Plug 'svermeulen/vim-easyclip'
    " Allows number base conversion
    Plug 'glts/vim-radical'
    Plug 'glts/vim-magnum'
    " Crazy stuff (words manipulation)
    Plug 'tpope/vim-abolish'
    " Fix CAPS LOCK
    Plug 'suxpert/vimcaps'
    " Increment sequences
    Plug 'triglav/vim-visual-increment'
    " Surround
    Plug 'tpope/vim-surround'

    if exists('g:vscode')  " if it's on vscode
        " Easy motion for VSCode
        Plug 'ChristianChiarulli/vscode-easymotion'
        " Edit built-in command
        Plug 'kana/vim-altercmd'

    else
        " Better Syntax Support
        Plug 'sheerun/vim-polyglot'
        " Auto pairs for '(' '[' '{'
        Plug 'jiangmiao/auto-pairs'
        " One Dark Color Theme
        Plug 'joshdick/onedark.vim'
        " coc
        Plug 'neoclide/coc.nvim', {'branch': 'release'}
        " Airline Status Bar
        Plug 'vim-airline/vim-airline'
        Plug 'vim-airline/vim-airline-themes'
        " Theme
        Plug 'wadackel/vim-dogrun'
        " Ranger File-Explorer
        Plug 'kevinhwang91/rnvimr', {'do': 'make sync'}
        " FZF
        Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
        Plug 'junegunn/fzf.vim'
        " Updates working directory to the project opened
        Plug 'airblade/vim-rooter'
        " Colorizer
        Plug 'norcalli/nvim-colorizer.lua'
        " Rainbow Parenthesis
        Plug 'junegunn/rainbow_parentheses.vim'
        " Startify (project manager)
        Plug 'mhinz/vim-startify'
        " coc Snippers
        Plug 'honza/vim-snippets'
        " Codi
        Plug 'metakirby5/codi.vim'
        " Easymotion
        Plug 'easymotion/vim-easymotion'
        " Close HTML tags
        Plug 'alvan/vim-closetag'
        " Highlight other occurrences from under the cursor
        Plug 'RRethy/vim-illuminate'
        " Git integration
        Plug 'tpope/vim-fugitive'
        " Function to get current Git branch
        Plug 'itchyny/vim-gitbranch'
        " Search and replace word under cursor
        Plug 'wincent/scalpel'
        " Pulse cursorline after search (makes easier to find the cursor)
        Plug 'inside/vim-search-pulse'
        " Switch between single-line and multiline statement
        Plug 'AndrewRadev/splitjoin.vim'

        " Icons (must me the last plugin loaded)
        Plug 'ryanoasis/vim-devicons'
    endif

call plug#end()

" Automatically install missing plugins on startup
autocmd VimEnter *
  \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \|   PlugInstall --sync | q
  \| endif
