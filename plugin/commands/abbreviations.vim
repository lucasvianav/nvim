" TODO:
" https://www.reddit.com/r/neovim/comments/qdfaw8/is_there_a_way_to_set_abbreviations_through_lua/
" https://gitlab.com/yorickpeterse/dotfiles/-/blob/c2fd334e7690b1955a59b9f3f92149dbfb88f9f8/dotfiles/.config/nvim/lua/dotfiles/abbrev.lua

" commands I always get wrong
cabbrev E e
cabbrev E! e!
cabbrev e1 e!
cabbrev E1 e!
cabbrev Q q
cabbrev q1 q!

cabbrev W update
cabbrev w update
cabbrev Wq x
cabbrev wq x

" other commands
cabbrev bufo BufOnly
cabbrev qb BufClose
cabbrev wqb BqWrite

" Packer
cabbrev PS  PackerSync
cabbrev PC  PackerCompile
cabbrev PCl PackerClean
cabbrev PSt PackerStatus

" LSP
cabbrev LI LspInfo

