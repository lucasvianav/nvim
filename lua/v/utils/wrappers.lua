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
function M.inspect(...)
  local formatted = M.format_for_inspection(...)
  print(formatted)
  return ...
end

---Dump contents of an object below the cursor. Wraps `print(vim.inspect(args))`.
---@sources:
--- - https://github.com/akinsho/dotfiles/blob/148d1b720b296ad9ef6943da4e7b9d2c4f86c59b/.config/nvim/lua/as/globals.lua#L93-L109
--- - https://www.reddit.com/r/neovim/comments/p84iu2/useful_functions_to_explore_lua_objects/
---@vararg any
function M.dump_text(...)
  local objects, v = {}, nil
  for i = 1, select("#", ...) do
    v = select(i, ...)
    table.insert(objects, vim.inspect(v))
  end

  local lines = vim.split(table.concat(objects, "\n"), "\n")
  local lnum = vim.api.nvim_win_get_cursor(0)[1]
  vim.fn.append(lnum, lines)
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
  local with_symlinks = vim.tbl_map(vim.fn.expand, list)
  local no_symlink = vim.tbl_map(path.resolve, list)

  return tbl_utils.list_distinct(tbl_utils.merge_lists({ with_symlinks, no_symlink }))
end

return M
