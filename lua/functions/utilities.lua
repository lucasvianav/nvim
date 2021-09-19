local o   = vim.o
local fn  = vim.fn
local cmd = vim.cmd

--[[
Checks if `list` contains the element `x` using binary search. Only useful if `list` is sorted.
]]--
function _G.contains_bin(x, list)
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

--[[
Deletes all trailing whitespaces in a file if it's not binary nor a diff.
]]--
function _G.trim_trailing_whitespaces()
    if not o.binary and o.filetype ~= 'diff' then
        local current_view = fn.winsaveview()
        cmd([[keeppatterns %s/\s\+$//e]])
        fn.winrestview(current_view)
    end
end
