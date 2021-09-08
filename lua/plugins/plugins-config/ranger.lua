map('n', '<Leader>r', ':<C-U>RnvimrToggle<CR>')

local function set (property, value)
    vim.g['rnvimr_' .. property] = value
end

-- didn't work :c
-- set('enable_ex', true) -- replace netrw

