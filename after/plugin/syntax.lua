-- enable syntax highlighting, filetype detection and loading
-- of filetype-specific plugins and indentation configurations
pcall(vim.api.nvim_exec2, "syntax on", { output = false })
pcall(vim.api.nvim_exec2, "filetype plugin indent on", { output = false })
