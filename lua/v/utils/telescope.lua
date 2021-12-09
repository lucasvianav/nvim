local actions = require('telescope.actions')
local state = require('telescope.actions.state')

local M = {}

M.open_in_diff = function(prompt_bufnr)
    actions.close(prompt_bufnr)
    local commit_hash = state.get_selected_entry().value

    local ok_packer, packer = require('v.utils.packer').get_packer()

    if ok_packer then
        pcall(packer.loader, 'diffview.nvim')
        require('diffview').open(commit_hash .. '~1..' .. commit_hash)
    end
end

M.find_nvim = function()
    require('telescope.builtin').find_files({
        cwd = vim.fn.stdpath('config'),
        prompt_title = '~ neovim ~',
        results_title = 'Neovim Dotfiles',
    })
end

M.find_in_plugins = function()
    require('telescope.builtin').find_files({
        cwd = vim.fn.stdpath('data') .. '/site/pack/packer',
        prompt_title = '~ plugins ~',
    })
end

M.find_dotfiles = function()
    require('telescope.builtin').git_files({
        file_ignore_patterns = { 'icons/', 'themes/' },
        cwd = os.getenv('HOME') .. '/dotfiles',
        prompt_title = '~ dotfiles ~',
        results_title = 'Dotfiles',
    })
end

M.find_unimed = function()
    require('telescope.builtin').find_files({
        file_ignore_patterns = { 'parceiros/', 'libs/' },
        cwd = os.getenv('WORK_DIR') .. '/unimed-pj',
        prompt_title = '~ unimed ~',
        results_title = 'Unimed Files',
    })
end

M.grep_unimed = function()
    require('telescope.builtin').live_grep({
        file_ignore_patterns = { 'parceiros/' },
        cwd = os.getenv('WORK_DIR') .. '/unimed-pj',
        prompt_title = '~ grep unimed ~',
        results_title = 'Unimed',
    })
end

M.grep_last_search = function()
    local register = vim.fn.getreg('/'):gsub('\\<', ''):gsub('\\>', '')

    if register and register ~= '' then
        require('telescope.builtin').grep_string({
            path_display = { 'shorten' },
            search = register,
        })
    else
        require('telescope.builtin').live_grep()
    end
end

M.pickers = {
    center_dropdown = {
        theme = 'dropdown',
        previewer = false,
        layout_strategy = 'center',
    },

    code_actions = {
        theme = 'cursor',
        prompt_title = 'Code Actions',
    },
}

return M
