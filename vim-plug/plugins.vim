" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  "autocmd VimEnter * PlugInstall
  "autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/autoload/plugged')

    if exists('g:vscode')  " if it's on vscode
        " Which Key
        Plug 'liuchengxu/vim-which-key'
        " Quickscope
        Plug 'unblevable/quick-scope'
        " Press CTRL + / to comment
        Plug 'tpope/vim-commentary'
        " Easy motion for VSCode
        Plug 'ChristianChiarulli/vscode-easymotion'
        " Sneak
        Plug 'justinmk/vim-sneak'

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
        " Ranger File-Explorer
        Plug 'kevinhwang91/rnvimr', {'do': 'make sync'}
        " Press CTRL + / to comment
        Plug 'tpope/vim-commentary'
        " FZF
        Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
        Plug 'junegunn/fzf.vim'
        Plug 'airblade/vim-rooter'
        " Colorizer
        Plug 'norcalli/nvim-colorizer.lua'
        " Rainbow Parenthesis
        Plug 'junegunn/rainbow_parentheses.vim'
        " Startify (project manager)
        Plug 'mhinz/vim-startify'
        " Which Key
        Plug 'liuchengxu/vim-which-key'
        " Quickscope
        Plug 'unblevable/quick-scope'
        " Sneak
        Plug 'justinmk/vim-sneak'
        " coc Snippers
        Plug 'honza/vim-snippets'
        " Codi
        Plug 'metakirby5/codi.vim'
        " Easymotion
        Plug 'easymotion/vim-easymotion'
        " Close HTML tags
        Plug 'alvan/vim-closetag'
        " Icons
        Plug 'ryanoasis/vim-devicons'
        Plug 'kyazdani42/nvim-web-devicons'
        " Highlight other occurrences from under the cursor
        Plug 'RRethy/vim-illuminate'

    endif

call plug#end()

" Automatically install missing plugins on startup
autocmd VimEnter *
  \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \|   PlugInstall --sync | q
  \| endif
