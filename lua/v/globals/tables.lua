---If only one param is passed, the lists inside it will be merged.
---@param lists any[]
---@param ... any
---@return any[]
function table.merge_lists(lists, ...)
  local res = {}

  assert(type(lists) == "table")

  if #({...}) > 0 then
    lists = { lists, ... }
  end

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
