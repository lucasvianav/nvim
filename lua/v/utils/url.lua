local M = {}

---@param unencoded string
function M.url_encode(unencoded)
  local encoded = ''

  for char in unencoded:gmatch(".") do
    if char:match('[-_~a-zA-Z0-9]') then
      encoded = encoded .. char
    else
      local decimal = vim.fn.char2nr(char)
      encoded = encoded .. '%' .. vim.fn.printf("%02X", decimal)
    end
  end

  return encoded
end

return M
