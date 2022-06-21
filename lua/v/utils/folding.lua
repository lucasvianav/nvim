-- TODO: https://github.com/akinsho/dotfiles/blob/main/.config/nvim/plugin/folds.lua

local v = vim.v
local fn = vim.fn

local M = {}

function M.foldtext()
  local first_line = vim.trim(fn.getline(v.foldstart)):sub(1, 40)
  local n_lines = v.foldend - v.foldstart + 1
  local indent = string.rep(' ', fn.indent(v.foldstart))

  return indent .. '+-- ' .. first_line .. ' ... ↕ [' .. n_lines .. ' lines folded] --+'
end

return M
