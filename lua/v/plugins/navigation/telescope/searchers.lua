local M = {}
local pickers = require("v.plugins.navigation.telescope.pickers")
local plugins_path = require("v.lazy.utils").paths.plugins

M.find_nvim = function()
  pickers.find_files_fd({
    cwd = vim.fn.stdpath("config"),
    prompt_title = "~ neovim ~",
    results_title = "Neovim Dotfiles",
  })
end

M.find_in_plugins = function()
  pickers.find_files_fd({
    cwd = plugins_path,
    prompt_title = "~ nvim plugins ~",
    results_title = "Neovim Plugins",
  })
end

M.grep_in_plugins = function()
  pickers.multi_grep({
    cwd = plugins_path,
    prompt_title = "~ grep nvim plugins ~",
    results_title = "Neovim Plugins",
  })
end

M.find_dotfiles = function()
  pickers.find_files_fd({
    file_ignore_patterns = { "icons/", "themes/" },
    cwd = os.getenv("HOME") .. "/dotfiles",
    prompt_title = "~ dotfiles ~",
    results_title = "Dotfiles",
  })
end

M.grep_last_search = function()
  pickers.multi_grep({
    default_text = vim.fn.getreg("/"):gsub("\\<", ""):gsub("\\>", "") or "",
  })
end

return M
