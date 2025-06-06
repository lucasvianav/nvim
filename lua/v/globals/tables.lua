---If only one param is passed, the lists inside it will be merged.
---@generic T
---@param lists `T`|T[]
---@param ... T
---@return T
function table.merge_lists(lists, ...)
  local res = {}

  lists = type(lists) == "table" and lists or { lists } --[[@as table]]

  if #{ ... } > 0 then
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

---Maps keys in a table. Keep values unchanged.
---@generic X, Y, Z
---@param tbl table<`X`, `Y`>
---@param pred fun(key: X, value: Y): `Z`
---@return table<Z, Y>
function table.map_keys(tbl, pred)
  local res = {}
  for k, v in pairs(tbl) do
    local new_key = pred(k, v)
    if new_key ~= nil then
      res[new_key] = v
    end
  end
  return res
end

---Convert table to list of {key, value}
---@generic X, Y, Z
---@param tbl table<`X`, `Y`>
---@param pred fun(key: X, value: Y): `Z`
---@return Z[]
function table.map_items(tbl, pred)
  local res = {}
  for k, v in pairs(tbl) do
    table.insert(res, pred(k, v))
  end
  return res
end

---Convert table to list of {key, value}
---@generic R, S
---@param tbl table<`R`, `S`>
---@return { [1]: R, [2]: S }[]
function table.items(tbl)
  return table.map_items(tbl, function(k, v)
    return { k, v }
  end)
end
