---Split string into a table of strings using a separator
---@param input_str string The string to split
---@param sep string? The separator to use
---@return table table A table of strings
function string.split(input_str, sep)
  if sep == nil then
    sep = "%s"
  end

  local parts = {}
  local pattern = ("([^%s]+)"):format(sep)

  for part in input_str:gmatch(pattern) do
    table.insert(parts, part)
  end

  return parts
end

---@param self string
---@param pattern string
---@return boolean
function string:contains(pattern)
  return self:find(pattern, 1, true) ~= nil
end

---@param str string
---@param pattern string
---@return boolean
function string.starts_with(str, pattern)
  return str:sub(1, #pattern) == pattern
end

---@param self string
---@param pattern string
---@return boolean
function string:ends_with(pattern)
  return self:sub(-#pattern) == pattern
end
