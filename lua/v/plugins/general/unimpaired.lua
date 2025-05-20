-- https://github.com/akinsho/dotfiles/blob/f714d4cdd2de74c7393ca3ae69bdbb3619e06174/.config/nvim/plugin/mappings.lua#L128-L131
-- TODO: https://github.com/odnoletkov/dotfiles/blob/ba319018c881527149b80e23a0278afab91af228/.vim/plugin/jumpbuffer.vim

local feedkeys = vim.api.nvim_feedkeys
local t = require('v.utils.wrappers').termcode
local exec = vim.api.nvim_exec2

---Adds `count` blank lines above the selection.
---@param count? number
local blank_up_selection = function(count)
  if vim.api.nvim_get_mode().mode ~= 'V' then
    return
  end

  count = count or vim.v.count1

  -- saves selection positions
  local cursor_col = vim.fn.getpos('.')[3]
  local cursor_line = vim.fn.line('.') + vim.v.count1
  local visual_line = vim.fn.line('v') + vim.v.count1

  local higher_line = math.min(vim.fn.line('.'), vim.fn.line('v'))
  exec(higher_line .. 'put!=repeat(nr2char(10), ' .. count .. ')', { output = false })

  -- makes sure it's in normal mode
  exec('normal \\<Esc>', { output = false })

  -- restores selection
  local select = ('normal %sGV%sG%s|'):format(visual_line, cursor_line, cursor_col)
  exec(select, { output = false })
end

---Adds `count` blank lines below the selection.
---@param count? number
local blank_down_selection = function(count)
  if vim.api.nvim_get_mode().mode ~= 'V' then
    return
  end

  count = count or vim.v.count1

  -- saves selection positions
  local cursor_col = vim.fn.getpos('.')[3]
  local cursor_line = vim.fn.line('.')
  local visual_line = vim.fn.line('v')

  local lower_line = math.max(cursor_line, visual_line)
  exec(lower_line .. 'put=repeat(nr2char(10),' .. count .. ')', { output = false })

  -- makes sure it's in normal mode
  exec('normal \\<Esc>', { output = false })

  -- restores selection
  local select = ('normal %sGV%sG%s|'):format(visual_line, cursor_line, cursor_col)
  exec(select, { output = false })
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

---Last direction in which a line was duplicated.
---@type boolean
local dupl_dir_up

---Last count of duplicated lines.
---@type number
local dupl_count

---Duplicate a line to the specified direction.
---@param up? boolean
local duplicate_line = function(up)
  if up ~= nil then
    dupl_dir_up = up
    dupl_count = vim.v.count1
  elseif dupl_dir_up == nil then
    return
  end

  local cmd =
      string.rep('copy ' .. (dupl_dir_up and '-1' or '+0') .. ' | ', dupl_count):gsub(' | $', '')
  exec('silent!' .. cmd, { output = false })

  vim.fn['repeat#set'](t('<Plug>DuplicateLineRepeat'), dupl_count)
end

---Duplicate a selection to the specified direction.
---@param up? boolean
local duplicate_selection = function(up)
  if up ~= nil then
    dupl_dir_up = up
    dupl_count = vim.v.count1
  elseif dupl_dir_up == nil then
    return
  end

  -- saves selection positions
  local cursor_col = vim.fn.getpos('.')[3]
  local cursor_line = vim.fn.line('.')
  local visual_line = vim.fn.line('v')

  local higher_line = math.min(cursor_line, visual_line)
  local lower_line = math.max(cursor_line, visual_line)

  local range = higher_line .. ',' .. lower_line
  local length = lower_line - higher_line + 1

  -- copy up
  local i = 0
  while i < dupl_count do
    local cmd = range .. 'copy -1 | normal ' .. higher_line .. 'G'
    exec('silent! ' .. cmd, { output = false })
    i = i + 1
  end

  -- if the direction was not up, fix the selection
  if not up then
    -- leave visual mode
    exec('silent! normal! ' .. t('<Esc>'), { output = false })

    -- calculate the bottomost selection selection's
    -- position (length*i is the final offset)
    local new_visual_line = visual_line + i * length
    local new_cursor_line = cursor_line + i * length

    -- create a new selection maintaining the cursor column
    local cmd = 'normal ' .. new_visual_line .. 'GV' .. new_cursor_line .. 'G' .. cursor_col .. '|'
    exec('silent! ' .. cmd, { output = false })
  end

  vim.fn['repeat#set'](t('<Plug>DuplicateSelectionRepeat'), dupl_count)
end

-- :c
exec(
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
  { output = false }
)

require('v.utils.mappings').set_keybindings({
  -- <Space><Space> surrounds current line
  -- or selection with [count] blank lines
  { { 'n', 'x' }, '<Space><Space>', blank_around,                           { nowait = false } },
  { 'x',          '[<Space>',       blank_up_selection },
  { 'x',          ']<Space>',       blank_down_selection },

  -- alt + j/k moves current line or
  -- selection [count] lines up/down
  { 'n',          '<M-k>',          '<Plug>unimpairedMoveUp' },
  { 'n',          '<M-j>',          '<Plug>unimpairedMoveDown' },
  { 'x',          '<M-k>',          '<Plug>unimpairedMoveKeepSelectionUp' },
  { 'x',          '<M-j>',          '<Plug>unimpairedMoveKeepSelectionDown' },

  -- [d, ]d duplicates [count] lines above/below
  {
    'n',
    '[d',
    function()
      duplicate_line(true)
    end,
  },
  {
    'n',
    ']d',
    function()
      duplicate_line(false)
    end,
  },
  {
    'x',
    '[d',
    function()
      duplicate_selection(true)
    end,
  },
  {
    'x',
    ']d',
    function()
      duplicate_selection(false)
    end,
  },
  { 'n', '<Plug>DuplicateLineRepeat',      duplicate_line },
  { 'x', '<Plug>DuplicateSelectionRepeat', duplicate_selection },
})
