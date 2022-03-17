-- https://github.com/akinsho/dotfiles/blob/f714d4cdd2de74c7393ca3ae69bdbb3619e06174/.config/nvim/plugin/mappings.lua#L128-L131
-- TODO: move my unimpared fork stuff to here

local exec = vim.api.nvim_exec
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
    exec(higher_line .. 'put!=repeat(nr2char(10), ' .. count .. ')', false)

    -- makes sure it's in normal mode
    exec('normal \\<Esc>', false)

    -- restores selection
    local select = ('normal %sGV%sG%s|'):format(visual_line, cursor_line, cursor_col)
    exec(select, false)
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
    exec(lower_line .. 'put=repeat(nr2char(10),' .. count .. ')', false)

    -- makes sure it's in normal mode
    exec('normal \\<Esc>', false)

    -- restores selection
    local select = ('normal %sGV%sG%s|'):format(visual_line, cursor_line, cursor_col)
    exec(select, false)
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
