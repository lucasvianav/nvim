" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

call plug#begin('~/.config/nvim/autoload/plugged')

" Themes
Plug 'joshdick/onedark.vim'
Plug 'shaunsingh/nord.nvim'
Plug 'tyrannicaltoucan/vim-deep-space'
Plug 'wadackel/vim-dogrun'
Plug 'dracula/vim'
Plug 'iCyMind/NeoSolarized'
Plug 'folke/tokyonight.nvim'

" Which Key
Plug 'liuchengxu/vim-which-key'
" Quickscope
Plug 'unblevable/quick-scope'
" Press CTRL + / to comment
Plug 'tpope/vim-commentary'
" Perl Regex
Plug 'othree/eregex.vim'
" Enables . repeat for Plug-In maps
Plug 'tpope/vim-repeat'
" Fixes <C-A> and <C-X> for dates
Plug 'tpope/vim-speeddating'
" Better clipboard
Plug 'svermeulen/vim-easyclip'
" Crazy stuff (words manipulation)
Plug 'tpope/vim-abolish'
" Fix CAPS LOCK
Plug 'suxpert/vimcaps'
" Increment sequences
Plug 'triglav/vim-visual-increment'
" Surround
Plug 'tpope/vim-surround'
" Better Syntax Support
Plug 'sheerun/vim-polyglot'
" Auto pairs for '(' '[' '{'
Plug 'jiangmiao/auto-pairs'
" coc
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Airline Status Bar
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
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
" Fancy buffer line
Plug 'akinsho/nvim-bufferline.lua'
" Autoedit enclosing HTML tag
Plug 'AndrewRadev/tagalong.vim'
" Highlight encolsing HTML tag
Plug 'valloric/MatchTagAlways'
" Align blocks of code
Plug 'junegunn/vim-easy-align'
" Work with LaTeX
Plug 'lervag/vimtex'
" Navigate seamlessly between vim widows and TMUX panes
Plug 'christoomey/vim-tmux-navigator'
" Perform bash commands (in TMUX pane) from Neovim
Plug 'https://github.com/preservim/vimux'
" Custom indent block text object
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-indent'

" " Telescope
" Plug 'nvim-lua/popup.nvim'
" Plug 'nvim-lua/plenary.nvim'
" Plug 'nvim-telescope/telescope.nvim'

" Icons (must be the last plugin loaded)
Plug 'kyazdani42/nvim-web-devicons'
" Plug 'ryanoasis/vim-devicons'

call plug#end()

" Automatically install missing plugins on startup
autocmd VimEnter *
  \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \|   PlugInstall --sync | q
  \| endif
