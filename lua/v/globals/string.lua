---@param self string
---@return string
function string:trim()
  return vim.trim(self)
end

---Split string into a table of strings using a separator
---@param self string The string to split
---@param sep string? The separator to use
---@return string[]
function string:split(sep)
  if sep == nil then
    sep = "%s"
  end
  return vim.split(self, sep, { trimempty = true })
end

---@param self string
---@param pattern string
---@return boolean
function string:contains(pattern)
  return self:find(pattern, 1, true) ~= nil
end

---@param self string
---@param pattern string
---@return boolean
function string:starts_with(pattern)
  return self:sub(1, #pattern) == pattern
end

---@param self string
---@param pattern string
---@return boolean
function string:ends_with(pattern)
  return self:sub(-#pattern) == pattern
end

---@param self string
---@return boolean?
function string:to_boolean()
  if self == "true" then
    return true
  elseif self == "false" then
    return false
  end
  return nil
end
