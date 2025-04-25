local fn = vim.fn
local cmd = vim.api.nvim_command

local function get_cwd_session_path()
  local expanded_dir = vim.fn.stdpath('data') .. '/sessions/'
  local cwd = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:g')
  local encoded_cwd = require('v.utils.url').url_encode(cwd)

  return expanded_dir .. encoded_cwd .. '.vim'
end

local function load_dashboard()
  cmd('silent! Dashboard')
end

local function load_cwd_session()
  cmd('silent! SessionRestore')
end

local M = {}

function M.get_cwd_session_path_if_exists()
  local session_path = get_cwd_session_path()
  return (fn.filereadable(session_path) == 1) and session_path or nil
end

function M.session_exists_for_cwd()
  return M.get_cwd_session_path_if_exists() ~= nil
end

---Loads the current dir's session if there is one.
function M.load_cwd_session()
  local auto_session_ok, auto_session = pcall(require, 'auto-session')

  if not auto_session_ok then
    require('v.utils.log').log(auto_session)
    vim.notify("Couldn't load `auto-session`.", vim.log.levels.ERROR, {
      title = 'Error - Session',
    })
    return false
  end

  if M.session_exists_for_cwd() then
    load_cwd_session()
    return true
  end

  return false
end

---Load the current dir's session if there is one, otherwise starts Dashboard.
---Also considers if Neovim was started with arguments.
function M.load_session_or_dashboard()
  local command = fn.trim(fn.system([[tr "\0" " " </proc/]] .. fn.getpid() .. '/cmdline'))
  local opened_nvim_without_file_arg = command:match('nvim$') or command:match('nvim %-%-embed$')

  if opened_nvim_without_file_arg and not M.load_cwd_session() then
    load_dashboard()
  end
end

M.load_session_or_dashboard()

return M
