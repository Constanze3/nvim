local M = {}

--- Extends a `destination` table with a `source` table.
---
--- @param destination table
--- @param source table
function M.extend(destination, source)
    table.move(source, 1, #source, #destination + 1, destination)
end

--- Copies a table.
---
--- @param tbl table
--- @return table tbl_copy
function M.copy(tbl)
    local tbl_copy = {}
    for k, v in pairs(tbl) do
        tbl_copy[k] = v
    end
    return tbl_copy
end

--- Returns true if `list` contains all `values`.
---
--- @param list table
--- @param values table
--- @return boolean
function M.contains_multiple(list, values)
    local values_copy = M.copy(values)
    for _, v1 in ipairs(list) do
        for i2, v2 in ipairs(values) do
            if v1 == v2 then
                table.remove(values_copy, i2)
                break
            end
        end

        if next(values_copy) == nil then
            return true
        end
    end

    return false
end

return M
