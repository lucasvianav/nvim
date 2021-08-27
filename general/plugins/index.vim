" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

call plug#begin('~/.config/nvim/autoload/plugged')

" themes
Plug 'joshdick/onedark.vim'
" Plug 'shaunsingh/nord.nvim'
" Plug 'tyrannicaltoucan/vim-deep-space'
" Plug 'wadackel/vim-dogrun'
" Plug 'dracula/vim'
" Plug 'iCyMind/NeoSolarized'
" Plug 'folke/tokyonight.nvim'

" plugins
" Plug 'lervag/vimtex'                                           " work with latex
Plug 'AndrewRadev/splitjoin.vim'                               " switch between single-line and multiline statement
Plug 'AndrewRadev/tagalong.vim'                                " autoedit enclosing html tag
Plug 'RRethy/vim-illuminate'                                   " highlight other occurrences from under the cursor
Plug 'airblade/vim-rooter'                                     " updates working directory to the project opened
Plug 'akinsho/nvim-bufferline.lua'                             " fancy buffer line
Plug 'alvan/vim-closetag'                                      " autoclose html tags
Plug 'christoomey/vim-tmux-navigator'                          " navigate seamlessly between vim widows and tmux panes
Plug 'easymotion/vim-easymotion'                               " get around very quickly
Plug 'honza/vim-snippets'                                      " snippets!!
Plug 'inside/vim-search-pulse'                                 " pulse cursorline after search (makes easier to find the cursor)
Plug 'itchyny/vim-gitbranch'                                   " provides function to get current git branch
Plug 'jiangmiao/auto-pairs'                                    " auto pairs for '(' '[' '{'
Plug 'jparise/vim-graphql'                                     " graphql support
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }            " fuzzy finder terminal commands
Plug 'junegunn/fzf.vim'                                        " fuzzy finder vim commands
Plug 'junegunn/rainbow_parentheses.vim'                        " color-highlight parenthesis/brackets pairs
Plug 'junegunn/vim-easy-align'                                 " align blocks of code
Plug 'kana/vim-textobj-indent'
Plug 'kana/vim-textobj-user'                                   " custom indent block text object
Plug 'kevinhwang91/rnvimr', {'do': 'make sync'}                " ranger file explorer
Plug 'liuchengxu/vim-which-key'                                " menu for <Leader> maps
Plug 'lucasvianav/vim-unimpaired'                              " pairs of handy bracket maps
Plug 'mattn/emmet-vim'                                         " html super snippets
Plug 'metakirby5/codi.vim'                                     " interactive scratchpad for js/ts
Plug 'mg979/vim-visual-multi', {'branch': 'master'}            " multiple cursors
Plug 'mhinz/vim-startify'                                      " start screen
Plug 'neoclide/coc.nvim', {'branch': 'release'}                " code completion
Plug 'norcalli/nvim-colorizer.lua'                             " highlight color codes
Plug 'preservim/vimux'                                         " run terminal commands in tmux pane from vim
Plug 'sheerun/vim-polyglot'                                    " better syntax support
Plug 'svermeulen/vim-easyclip'                                 " better clipboard
Plug 'tpope/vim-abolish'                                       " word manipulation maps/commands
Plug 'tpope/vim-capslock'                                      " virtual caps lock maps
Plug 'tpope/vim-commentary'                                    " maps for toggling comments
Plug 'tpope/vim-fugitive'                                      " git CLI for command mode
Plug 'tpope/vim-repeat'                                        " enables . repeat for plugin maps
Plug 'tpope/vim-speeddating'                                   " fixes <c-a> and <c-x> for dates
Plug 'tpope/vim-surround'                                      " surrounding manipulatiuon maps
Plug 'triglav/vim-visual-increment'                            " increment sequences with visual block
Plug 'unblevable/quick-scope'                                  " better t/T, s/S (underline)
Plug 'valloric/MatchTagAlways'                                 " highlight enclosing html tag
Plug 'vim-airline/vim-airline'                                 " airline status bar
Plug 'vim-airline/vim-airline-themes'                          " airline status bar themes
Plug 'wellle/targets.vim'                                      " provides great new text objects

" TSDoc documentation comments generation
Plug 'heavenshell/vim-jsdoc', {
  \ 'for': ['javascript', 'javascript.jsx','typescript'],
  \ 'do': 'make install'
\}

" icons (must be the last plugin loaded)
Plug 'kyazdani42/nvim-web-devicons'

call plug#end()

" automatically install missing plugins on startup
autocmd VimEnter *
  \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \|   PlugInstall --sync | q
  \| endif
