local fn = vim.fn
local cmd = vim.api.nvim_command

local M = {}

M.colors = require("v.utils.colors")

-- TODO: great utilities https://github.com/JoosepAlviste/dotfiles/blob/master/config/nvim/lua/j/utils.lua
-- TODO: https://github.com/jose-elias-alvarez/dotfiles/blob/main/.config/nvim/lua/utils.lua
-- TODO: function to read last 500 lines from lsp log
-- TODO: https://gitlab.com/yorickpeterse/dotfiles/-/blob/c2fd334e7690b1955a59b9f3f92149dbfb88f9f8/dotfiles/.config/nvim/lua/dotfiles/abbrev.lua

---Deletes all trailing whitespaces in a file if it's not binary nor a diff.
function M.trim_trailing_whitespaces()
  local o = vim.o
  if not o.binary and o.filetype ~= "diff" then
    local current_view = fn.winsaveview()
    cmd([[keeppatterns %s/\s\+$//e]])
    fn.winrestview(current_view)
  end
end

---Return the path to the current lua file inside `nvim/lua/` in order to require it.
local function _get_current_require_path()
  local filepath = vim.api.nvim_buf_get_name(0)
  local regexp = [[^.\+nvim/lua/\(.\+\)\.lua$]]

  if not vim.regex(regexp):match_str(filepath) then
    return nil
  else
    filepath = fn.substitute(filepath, regexp, [[\1]], "")
    filepath = fn.substitute(filepath, [[\.lua$]], [[]], "")
    filepath = fn.substitute(filepath, "/", ".", "g")
    return filepath
  end
end

---Sources the current file if it's VimL and reloads (w/ `require`) if it's Lua.
function M.reload_or_source_current()
  local filetype = vim.opt_local.ft._value
  local require_path = _get_current_require_path()
  local action

  if filetype == "lua" and require_path then
    require("v.utils.wrappers").reload(require_path)
    action = "Reloaded "
  elseif filetype == "vim" or filetype == "lua" then
    cmd("source %")
    action = "Sourced "
  else
    return
  end

  vim.notify(action .. "\"" .. vim.fn.expand("%") .. "\".", "info", {
    title = "File reloading...",
  })
end

---Sets all VimL options for a plugin from a `opts` table.
function M.set_viml_options(lead, opts, unique_value)
  lead = lead or ""

  local no_uppercase_initial = lead:match("^[^A-Z]")
  local is_caps_lock = lead:match("^[A-Z]+$")
  local has_no_separator = lead:match("[a-zA-Z0-9]$")

  if (no_uppercase_initial or is_caps_lock) and has_no_separator then
    lead = lead .. "_"
  end

  if unique_value then
    if type(unique_value) == "boolean" then
      unique_value = unique_value and 1 or 0
    end

    for i, option in ipairs(opts) do
      vim.g[lead .. option] = unique_value
      opts[i] = nil
    end
  end

  for option, value in pairs(opts) do
    if type(value) == "boolean" then
      value = value and 1 or 0
    end

    vim.g[lead .. option] = value
  end
end

---Uses Plenary to get a relative path to `filepath` from the cwd.
---@param filepath string
---@return string|nil
function M.get_relative_path(filepath)
  local is_plenary_loaded, plenary = pcall(require, "plenary.path")

  if is_plenary_loaded then
    local parsed_path = filepath:gsub("file://", "")
    local relative_path = plenary:new(parsed_path):make_relative(vim.fn.getcwd())
    return "./" .. relative_path
  end

  return nil
end

---Executes the current line in VimL or Lua
---@return nil
M.exec_line_or_make = function()
  local filetype = vim.opt_local.ft._value

  if vim.tbl_contains({ "c", "cpp" }, filetype) then
    vim.api.nvim_command("make")
    return
  elseif not vim.tbl_contains({ "lua", "vim" }, filetype) then
    return
  end

  local mode = vim.api.nvim_get_mode().mode
  local line = vim.fn.line(".")
  local command

  if mode == "V" then
    local start_visual = vim.fn.line("v")
    command = vim.api.nvim_buf_get_lines(0, start_visual - 1, line, false)
    line = math.min(line, start_visual) .. ":" .. math.max(line, start_visual)
  elseif mode == "n" then
    command = { vim.api.nvim_get_current_line() }
  else
    return
  end

  if filetype == "lua" then
    command = "lua << EOF\n" .. table.concat(command, "\n") .. "\nEOF"
  end

  local ok, err = pcall(vim.api.nvim_exec2, command, { output = false })

  local file = string.gsub(vim.api.nvim_buf_get_name(0), [[^.+/(%w+/%w+)]], "%1")
  vim.notify(
    ("Executed %s, %s."):format(file, line) .. (ok and "" or ("\n[Error]: %s"):format(err)),
    ok and vim.log.levels.INFO or vim.log.levels.ERROR,
    { title = "Line Execution" }
  )
end

---Open a file with the same name as the current's but another extension.
---@param extension string the target-file's extension
---@return nil
M.open_file_swap_extension = function(extension)
  local filename = vim.api.nvim_buf_get_name(0):gsub("%.%w+$", "")
  cmd("e " .. filename .. "." .. extension)
end

---Add padding to the right of a string.
---@param str string string to be padded
---@param len number final length (for the padded string)
---@param char? string character to be pad the string with (default blankspace)
M.pad_string_right = function(str, len, char)
  if char == nil then
    char = " "
  elseif #char > 1 then
    char = char:sub(1, 1)
  end

  return str .. string.rep(char, len - #str)
end

return M
