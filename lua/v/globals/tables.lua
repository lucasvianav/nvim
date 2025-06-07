---If only one param is passed, the lists inside it will be merged.
---@param lists any|any[]
---@param ... any
---@return any[]
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

---@generic T
---@param tbl `T`[]
---@param sep? string
---@param pred? fun(it: T): string
---@return string?
function table.join(tbl, sep, pred)
  local res = nil ---@type string?
  sep = sep or ", "
  pred = pred or tostring

  for _, it in ipairs(tbl) do
    if not res then
      res = pred(it)
    else
      res = res .. sep .. pred(it)
    end
  end

  return res
end

---@param tbl table
---@return any[]
function table.distinct(tbl)
  local hash, res = {}, {}
  for _, it in ipairs(tbl) do
    if not hash[it] then
      table.insert(res, it)
      hash[it] = true
    end
  end
  return res
end
