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

--- Returns ture if `list` contains `value`
---
--- @param list table
--- @param value any
--- @return boolean
function M.contains(list, value)
	for _, v in ipairs(list) do
		if v == value then
			return true
		end
	end

	return false
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

--- The name of the current git branch or "" if the project is not a git repository.
---
--- @return string
function M.current_branch()
	local success, branch_name = pcall(vim.fn.system, "git branch --show-current")

	if success then
		return (branch_name:gsub("\n", ""))
	else
		return ""
	end
end

--- The list of git branches.
---
--- @return table
function M.branches()
	local result = {}
	local success, branch_names = pcall(vim.fn.system, "git branch -l --format=%(refname:short)")

	if success then
		for branch_name in string.gmatch(branch_names, "([^\n]+)") do
			table.insert(result, branch_name)
		end
	end

	return result
end

return M
