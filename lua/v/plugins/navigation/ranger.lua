map('n', '<Leader>r', '<CMD>RnvimrToggle<CR>')

local function set(property, value)
    vim.g['rnvimr_' .. property] = value
end

set('enable_ex', 1) -- replace netrw
set('enable_picker', 1) -- hide after picking file
set('action', {
    ['<C-t>'] = 'NvimEdit tabedit',
    ['<C-x>'] = 'NvimEdit split',
    ['<C-h>'] = 'NvimEdit split',
    ['<C-v>'] = 'NvimEdit vsplit',
    gw = 'JumpNvimCwd',
    yw = 'EmitRangerCwd',
})
