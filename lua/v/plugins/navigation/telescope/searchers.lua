local M = {}
local pickers = require("v.plugins.navigation.telescope.pickers")

M.find_nvim = function()
  require("telescope.builtin").find_files({
    cwd = vim.fn.stdpath("config"),
    prompt_title = "~ neovim ~",
    results_title = "Neovim Dotfiles",
  })
end

M.find_in_plugins = function()
  require("telescope.builtin").find_files({
    cwd = vim.fn.stdpath("data") .. "/site/pack/packer",
    prompt_title = "~ plugins ~",
    results_title = "Packer Plugins",
  })
end

M.grep_in_plugins = function()
  pickers.multi_grep({
    cwd = vim.fn.stdpath("data") .. "/site/pack/packer",
    prompt_title = "~ grep plugins ~",
    results_title = "Packer Plugins",
  })
end

M.find_dotfiles = function()
  require("telescope.builtin").git_files({
    file_ignore_patterns = { "icons/", "themes/" },
    cwd = os.getenv("HOME") .. "/dotfiles",
    prompt_title = "~ dotfiles ~",
    results_title = "Dotfiles",
  })
end

M.grep_cur_dir = function()
  pickers.multi_grep({
    cwd = require("telescope.utils").buffer_dir(),
    prompt_title = "~ grep current file's dir ~",
    results_title = "Current Dir",
  })
end

M.grep_last_search = function()
  local register = vim.fn.getreg("/"):gsub("\\<", ""):gsub("\\>", "")

  if register and register ~= "" then
    require("telescope.builtin").grep_string({
      path_display = { "shorten" },
      search = register,
    })
  else
    pickers.multi_grep()
  end
end

return M
