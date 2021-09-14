--[[
Checks if `list` contains the element `x` using binary search. Only useful if `list` is sorted.
]]--
function _G.containsBin(x, list)
    local middle
    local start = 1
    local size = #list

    while(start <= size) do
        middle = math.floor((start + size)/2)

        if x == list[middle] then
            return true
        elseif x < list[middle] then
            size = middle - 1
        else
            start = middle + 1
        end
    end

    return false
end

--[[
Checks if `list` contains the element `x`.
]]--
function _G.contains(x, list)
    for _, y in pairs(list) do
        if x == y then return true end
    end

    return false
end

