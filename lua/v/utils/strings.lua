local M = {}

---Split string into a table of strings using a separator
---@param input_str string The string to split
---@param sep string? The separator to use
---@return table table A table of strings
string.split = function(input_str, sep)
  if sep == nil then
    sep = "%s"
  end

  local parts = {}
  local pattern = ("([^%s]+)"):format(sep)

  for part in string.gmatch(input_str, pattern) do
    table.insert(parts, part)
  end

  return parts
end

M.split = string.split

return M
