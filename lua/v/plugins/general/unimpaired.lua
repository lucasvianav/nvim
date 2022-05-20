-- https://github.com/akinsho/dotfiles/blob/f714d4cdd2de74c7393ca3ae69bdbb3619e06174/.config/nvim/plugin/mappings.lua#L128-L131
-- TODO: https://github.com/odnoletkov/dotfiles/blob/ba319018c881527149b80e23a0278afab91af228/.vim/plugin/jumpbuffer.vim

local feedkeys = vim.api.nvim_feedkeys

---Adds `count` blank lines above the selection.
---@param count? number
local blank_up_selection = function(count)
  if vim.api.nvim_get_mode().mode ~= 'V' then
    return
  end

  count = count or vim.v.count1

  -- saves selection positions
  local cursor_col = vim.fn.getpos('.')[2]
  local cursor_line = vim.fn.line('.') + vim.v.count1
  local visual_line = vim.fn.line('v') + vim.v.count1

  local higher_line = math.min(vim.fn.line('.'), vim.fn.line('v'))
  vim.api.nvim_exec(higher_line .. 'put!=repeat(nr2char(10), ' .. count .. ')', false)

  -- makes sure it's in normal mode
  vim.api.nvim_exec('normal \\<Esc>', false)

  -- restores selection
  local select = ('normal %sGV%sG%s|'):format(visual_line, cursor_line, cursor_col)
  vim.api.nvim_exec(select, false)
end

---Adds `count` blank lines below the selection.
---@param count? number
local blank_down_selection = function(count)
  if vim.api.nvim_get_mode().mode ~= 'V' then
    return
  end

  count = count or vim.v.count1

  -- saves selection positions
  local cursor_col = vim.fn.getpos('.')[2]
  local cursor_line = vim.fn.line('.')
  local visual_line = vim.fn.line('v')

  local lower_line = math.max(cursor_line, visual_line)
  vim.api.nvim_exec(lower_line .. 'put=repeat(nr2char(10),' .. count .. ')', false)

  -- makes sure it's in normal mode
  vim.api.nvim_exec('normal \\<Esc>', false)

  -- restores selection
  local select = ('normal %sGV%sG%s|'):format(visual_line, cursor_line, cursor_col)
  vim.api.nvim_exec(select, false)
end

---Adds blank lines around the selection.
local blank_around = function()
  local count = vim.v.count1

  if vim.api.nvim_get_mode().mode == 'V' then
    blank_up_selection(count)
    blank_down_selection(count)
  elseif vim.api.nvim_get_mode().mode == 'n' then
    feedkeys(('%d%c%c%cunimpairedBlankUp'):format(count, 0x80, 253, 83), 'n', false)
    feedkeys(('%d%c%c%cunimpairedBlankDown'):format(count, 0x80, 253, 83), 'n', false)
  end
end

-- :c
vim.api.nvim_exec(
  [[
    function! ExecMove(cmd) abort
      let old_fdm = &foldmethod
      if old_fdm !=# 'manual'
          let &foldmethod = 'manual'
      endif
      normal! m`
      silent! exe a:cmd
      norm! ``
      if old_fdm !=# 'manual'
          let &foldmethod = old_fdm
      endif
    endfunction

    function! MoveKeepSelectionUp(count) abort
      call ExecMove("'<,'>move'<--".a:count)
      call feedkeys('gv=', 'n')
      call feedkeys('gv', 'n')
      silent! call repeat#set("\<Plug>unimpairedMoveSelectionUp", a:count)
    endfunction

    function! MoveKeepSelectionDown(count) abort
      call ExecMove("'<,'>move'>+".a:count)
      call feedkeys('gv=', 'n')
      call feedkeys('gv', 'n')
      silent! call repeat#set("\<Plug>unimpairedMoveSelectionDown", a:count)
    endfunction

    noremap  <silent> <Plug>unimpairedMoveKeepSelectionUp   :<C-U>call MoveKeepSelectionUp(v:count1)<CR>
    noremap  <silent> <Plug>unimpairedMoveKeepSelectionDown :<C-U>call MoveKeepSelectionDown(v:count1)<CR>
]],
  false
)

require('v.utils.mappings').set_keybindings({
  -- <Space><Space> surrounds current line
  -- or selection with [count] blank lines
  { { 'n', 'x' }, '<Space><Space>', blank_around, nowait = false },
  { 'x', '[<Space>', blank_up_selection },
  { 'x', ']<Space>', blank_down_selection },

  -- alt + j/k moves current line or
  -- selection [count] lines up/down
  { 'n', '<M-k>', '<Plug>unimpairedMoveUp' },
  { 'n', '<M-j>', '<Plug>unimpairedMoveDown' },
  { 'x', '<M-k>', '<Plug>unimpairedMoveKeepSelectionUp' },
  { 'x', '<M-j>', '<Plug>unimpairedMoveKeepSelectionDown' },
})
