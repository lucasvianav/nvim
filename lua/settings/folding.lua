local o  = vim.opt
local fn = vim.fn

-- local treesitterEnabled, ts = pcall(require,'nvim-treesitter.configs')
-- 
-- -- use treesitter for folding
-- -- if available, else indent
-- if treesitterEnabled then
--     o.foldmethod = 'expr'
--     o.foldexpr   = fn['nvim_treesitter#foldexpr']()
-- else
--     o.foldmethod = 'indent'
-- end

o.foldmethod = 'indent'

--[[
    autocmd VimEnter,VimLeave * bufdo set foldlevel=0
    autocmd BufAdd,Bufnew <afile> set foldlevel=0
    " set foldlevelstart=0                " start folded
endif
]]--

