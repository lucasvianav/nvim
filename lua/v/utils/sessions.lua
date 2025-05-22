local fn = vim.fn
local utils = require("v.utils.packer")

local function get_cwd_session_path()
  local expanded_dir = vim.fn.stdpath("data") .. "/sessions/"
  local cwd = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:g")
  local encoded_cwd = require("v.utils.url").url_encode(cwd)

  return expanded_dir .. encoded_cwd .. ".vim"
end

local function load_dashboard()
  vim.api.nvim_command("silent! Dashboard")
end

---@param session_filepath string
local function load_session(session_filepath)
  local auto_session_ok, auto_session = utils.load_and_require_plugin("auto-session")

  if auto_session_ok then
    auto_session.RestoreSessionFile(session_filepath, {
      is_startup_autorestore = false,
      show_message = false,
    })
  end
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
  local auto_session_ok, auto_session = utils.load_and_require_plugin("auto-session")

  if not auto_session_ok then
    require("v.utils.log").log(auto_session)
    vim.notify("Couldn't load `auto-session`.", vim.log.levels.ERROR, {
      title = "Error - Session",
    })
    return false
  end

  local cwd_session_filepath = M.get_cwd_session_path_if_exists()

  if cwd_session_filepath ~= nil then
    load_session(cwd_session_filepath)
    return true
  end

  return false
end

---Load the current dir's session if there is one, otherwise starts Dashboard.
---Also considers if Neovim was started with arguments.
function M.load_session_or_dashboard()
  local command = fn.trim(
    fn.system(
      [[ps aux | grep ]]
        .. fn.getpid()
        .. [[ | awk '$2 == "]]
        .. fn.getpid()
        .. [[" { col = ""; for (i = 11; i <= NF; i++) col = col $i " "; print col }']]
    )
  )
  local opened_nvim_without_file_arg = command:match("nvim$") or command:match("nvim %-%-embed$")

  if opened_nvim_without_file_arg and not M.load_cwd_session() then
    load_dashboard()
  end
end

return M
