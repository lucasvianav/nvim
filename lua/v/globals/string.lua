---@param self string
---@return string
function string:trim()
  return vim.trim(self)
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

---Split string into a table of strings using a separator
---@param self string The string to split
---@param sep (string|integer)? Separator (if string) or width (if number)
---@return string[]
function string:split(sep)
  if sep == nil then
    sep = "%s"
  end

  if type(sep) == "string" then
    return vim.split(self, sep, { trimempty = true })
  else
    local lines, res = self:split("\n"), {}

    for n_line, line in ipairs(lines) do
      local width, i = sep, 1

      while i <= #line do
        local block = line:sub(i, i + width - 1):trim()
        if n_line > 1 then
          block = "\n" .. block
        end

        table.insert(res, block)
        i = i + width
      end
    end

    return res
  end

  -- TODO: wrap buf don't break words in the middle
  -- local width, i, res = sep, 1, {}
  --
  -- while i <= #self do
  --   local j = i + width - 1
  --   local line = self:sub(i, i + width - 1):trim()
  --
  --   if word_aware then
  --     while line[#line] ~= " " and j - i <= 1.5 * width do
  --       line = self:sub(i, j)
  --       j = j + 1
  --     end
  --   end
  --
  --   table.insert(res, line)
  --   i = j + 1
  -- end
  --
  -- return res
end

---@param self string
---@param width integer
---@return string
function string:wrap(width)
  return table.join(self:split(width), "\n") or ""
end
