local function keybindings(file) require('keybindings.' .. file) end

local M = {
    general = keybindings('general'),
    navigation = keybindings('navigation'),
    shortcuts = keybindings('shortcuts'),
    unmappings = keybindings('unmappings'),
}

return M
