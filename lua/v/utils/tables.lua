local M = {}

local util = require("v.utils.numbers")

---@param tbl table
---@return boolean
M.has_implicit_fields = function(tbl)
  return #tbl > 0
end

---@param tbl table
---@return boolean
M.has_both_implicit_and_named_fields = function(tbl)
  local has_implicit_fields = M.has_implicit_fields(tbl)
  local has_named_fields = false

  for k, _ in pairs(tbl) do
    if type(k) ~= "number" or not util.is_int(k) or k > #tbl then
      has_named_fields = true
      break
    end
  end

  return has_implicit_fields and has_named_fields
end

---@generic T : table<integer|string, any>
---@param fields table<integer, string>
---@param values T
---@return T
function M.merge_named_and_pos_fields(fields, values)
  if M.has_both_implicit_and_named_fields(values) then
    local msg = "Table must have only named fields or only implicit positional fields."
    require("v.utils.log").log(msg)
    vim.notify(msg)
    vim.print(msg)
    error(msg)
  end

  local output = {}

  for i, name in ipairs(fields) do
    if values[i] then
      output[i] = values[i]
      output[name] = values[i]
    elseif values[name] then
      output[i] = values[name]
      output[name] = values[name]
    end
  end

  return output
end

---@param tbl table
---@return any[]
function M.list_distinct(tbl)
  local hash = {}
  local res = {}

  for _, element in ipairs(tbl) do
    if not hash[element] then
      res[#res + 1] = element
      hash[element] = true
    end
  end

  return res
end

---@param lists any[]
---@return any[]
function M.merge_lists(lists)
  local res = {}

  for _, element in ipairs(lists) do
    if type(element) == "table" then
      for _, v in ipairs(element) do
        res[#res + 1] = v
      end
    else
      res[#res + 1] = element
    end
  end

  return res
end

---@param tbl table
---@return table
function M.filter_non_nil(tbl)
  return vim.tbl_filter(function(it)
    return it ~= nil
  end, tbl)
end

return M
