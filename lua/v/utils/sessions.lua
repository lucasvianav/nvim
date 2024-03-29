local fn = vim.fn
local cmd = vim.api.nvim_command

local function get_cwd_session_path()
  local expanded_dir = vim.fn.stdpath('data') .. '/sessions/'
  local escaped_cwd = fn.fnamemodify(fn.getcwd(), ':p:h:gs?/?%?')

  return expanded_dir .. escaped_cwd .. '.vim'
end

local function load_dashboard()
  cmd('silent! Dashboard')
end

local M = {}

---Loads the current dir's session if there is one.
function M.load_cwd_session()
  local session = get_cwd_session_path()

  if fn.filereadable(session) == 1 then
    cmd('silent! RestoreSession')
    return true
  end

  return false
end

---Load the current dir's session if there is one, otherwise starts Dashboard.
---Also considers if Neovim was started with arguments.
function M.load_session_or_dashboard()
  local command = fn.trim(fn.system([[tr "\0" " " </proc/]] .. fn.getpid() .. '/cmdline'))

  if (command:match('nvim$') or command:match('nvim %-%-embed$')) and not M.load_cwd_session() then
    load_dashboard()
  end
end

return M
