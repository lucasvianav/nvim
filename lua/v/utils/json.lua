local M = {}

---@alias JsonElement string|number|nil|JsonTable

---@class JsonTable
---@field [string]? JsonElement|JsonElement[]

---@param filepath string
---@return JsonTable?
function M.from_file(filepath)
  local ok, file = pcall(io.open, filepath, "r")

  if not ok or not file then
    return nil
  end

  ---@type string
  local data = file:read("*a")

  file:close()

  return vim.json.decode(data)
end

return M
