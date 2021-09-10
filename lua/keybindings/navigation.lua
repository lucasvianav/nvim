-- buffer movement with \<Tab> and <S-Tab>
-- nnoremap <silent> \<TAB> :bnext<CR>
-- nnoremap <silent> <S-TAB> :bprevious<CR>

-- toggle buffer last visited buffer
-- nnoremap { <Leader><Tab>, <C-^>, { silent = true } }
map('n', '<BS>', '<C-^>')

-- better window navigation
map('n', '<C-h>', '<C-w>h')
map('n', '<C-j>', '<C-w>j')
map('n', '<C-k>', '<C-w>k')
map('n', '<C-l>', '<C-w>l')

-- better nav for omnicomplete
-- inoremap { '<c-j>', "\<C-n>", { expr = true }
-- inoremap { '<c-k>', "\<C-p>", { expr = true }

-- nnoremap '' ``

