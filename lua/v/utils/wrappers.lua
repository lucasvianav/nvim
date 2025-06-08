local M = {}

local path = require("v.utils.paths")
local tbl_utils = require("v.utils.tables")

---Wrapper for `vim.api.nvim_replace_termcodes`. Same as escaping a key code in VimL ('t' for 'termcodes').
---e.g.: t'<Esc>' in lua is the same as "\<Esc>" in VimL.
function M.termcode(key)
  return vim.api.nvim_replace_termcodes(key, true, true, true)
end

---@param module string module to be loaded
---@returns function requires the module when executed
function M.loadfile(module)
  return function()
    return require(module)
  end
end

function M.format_for_inspection(...)
  local objects, v = {}, nil
  for i = 1, select("#", ...) do
    v = select(i, ...)
    table.insert(
      objects,
      vim.inspect(v, {
        indent = "    ",
        depth = 4,
      })
    )
  end

  return table.concat(objects, "\n")
end

---Inspect contents of an object. Wraps `print(vim.inspect(args))`.
---@sources:
--- - https://github.com/akinsho/dotfiles/blob/148d1b720b296ad9ef6943da4e7b9d2c4f86c59b/.config/nvim/lua/as/globals.lua#L93-L109
--- - https://www.reddit.com/r/neovim/comments/p84iu2/useful_functions_to_explore_lua_objects/
---@vararg any
---@return any
function M.inspect(...)
  local formatted = M.format_for_inspection(...)
  print(formatted)
  return ...
end

---@vararg any
---@return any
function M.dump_inspection(...)
  local args, lines = { ... }, {}

  for _, it in ipairs(args) do
    local str = type(it) == "string" and it or M.format_for_inspection(it)
    local it_lines = str:trim():split("\n")
    for _, line in ipairs(it_lines) do
      if line:match("%S") then
        table.insert(lines, line)
      end
    end
  end

  local bufnr = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, lines)
  local winnr = vim.api.nvim_open_win(bufnr, true, { split = "below", win = 0 })
  vim.api.nvim_win_set_cursor(winnr, { vim.api.nvim_buf_line_count(bufnr), 0 })

  vim.api.nvim_buf_set_name(bufnr, ("[dump_%d]"):format(bufnr))
  vim.api.nvim_set_option_value("modified", false, { buf = bufnr })
  vim.api.nvim_set_option_value("modified", false, { buf = bufnr })
  vim.api.nvim_set_option_value("wrap", true, { win = winnr })
  vim.api.nvim_set_option_value("filetype", "v_dump", { buf = bufnr })
  vim.api.nvim_set_option_value("buftype", "nofile", { buf = bufnr })
  vim.api.nvim_set_option_value("bufhidden", "wipe", { buf = bufnr })

  return ...
end

---Reload a lua module using Plenary.
function M.reload(module)
  local is_plenary_loaded, plenary = pcall(require, "plenary.reload")

  if is_plenary_loaded then
    plenary.reload_module(module)
    return require(module)
  else
    return nil
  end
end

---Returns a function to require files inside `dir`.
---@param dir string
---@return function
function M.get_require_submodule(dir)
  return function(file)
    local module = dir .. "." .. file
    local ok, output = pcall(require, module)

    if not ok then
      vim.notify(
        "Couldn't load module [" .. module .. "].",
        vim.log.levels.ERROR,
        { title = "Error" }
      )
    end

    return output
  end
end

---Expands (`vim.fn.expand`) every element in the list.
---@param list string[]
---@return string[]
M.expand_in_list = function(list)
  local with_symlinks = vim.tbl_map(vim.fs.abspath, list)
  local no_symlink = vim.tbl_map(vim.fn.resolve, with_symlinks)
  return tbl_utils.list_distinct(tbl_utils.merge_lists({ with_symlinks, no_symlink }))
end

return M
