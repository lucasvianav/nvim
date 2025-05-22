local M = {}

---@param n number
---@return boolean
M.is_int = function(n)
  return type(n) == "number" and n % 1 == 0
end

return M
