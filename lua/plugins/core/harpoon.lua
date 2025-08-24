local util = require("custom/util")

local function list_name_for_branch(branch_name)
	local list_name = ""

	if branch_name ~= "" then
		list_name = "branch/" .. branch_name
	end

	return list_name
end

local function branch_local_list()
	local harpoon = require("harpoon")

	local branch_name = util.current_branch()
	local list_name = list_name_for_branch(branch_name)

	return harpoon:list(list_name)
end

return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"folke/which-key.nvim",
	},
	config = function()
		local harpoon = require("harpoon")

		vim.g.harpoon_term_index = 1
		harpoon:setup({
			terminals = {
				encode = false,
				create_list_item = function(_, _)
					local buf = vim.api.nvim_create_buf(true, false)

					vim.api.nvim_buf_call(buf, function()
						vim.cmd("term")
					end)

					vim.api.nvim_set_option_value("filetype", "terminal", { buf = buf })

					vim.api.nvim_create_autocmd("BufWinEnter", {
						buffer = buf,
						callback = function()
							vim.wo.signcolumn = "no"
							vim.opt.number = false
							vim.opt.relativenumber = false
						end,
					})

					vim.api.nvim_create_autocmd("BufWinLeave", {
						buffer = buf,
						callback = function()
							pcall(vim.g.apply_settings)
						end,
					})

					local idx = vim.g.harpoon_term_index
					vim.g.harpoon_term_index = idx + 1

					local name = string.format("terminal %d", idx)

					return {
						value = name,
						context = {
							buf = buf,
							idx = idx,
						},
					}
				end,
				select = function(list_item, _, _)
					local context = list_item.context

					vim.api.nvim_set_current_buf(context.buf)
					vim.notify(list_item.value, vim.log.levels.INFO)
				end,
			},
			branches = {
				select = function(list_item, _, _)
					local list_name = list_name_for_branch(list_item.value)
					local items = harpoon:list(list_name).items

					for _, item in ipairs(items) do
						branch_local_list():add({ value = item.value, context = {} })
					end
				end,
			},
		})

		local terminal_list = harpoon:list("terminals")
		local branch_list = harpoon:list("branches")

		-- branch local list

		-- delete branch local lists of branches that do not exist anymore
		-- sadly the keys are still written to files
		local branch_names = util.branches()
		harpoon:_for_each_list(function(list, _, name)
			if not (string.find(name, "^branch/")) then
				return
			end

			local associated_branch_name = (name:gsub("^branch/", ""))

			if not util.contains(branch_names, associated_branch_name) then
				list:clear()
				branch_list:remove(associated_branch_name)
			end
		end)

		require("which-key").add({
			group = "harpoon",
			icon = { icon = "󰛢", color = "red" },
			{
				"<leader>a",
				function()
					local branch_name = util.current_branch()

					if branch_name ~= "" then
						branch_list:remove({ value = branch_name, context = {} })
						branch_list:prepend({ value = branch_name, context = {} })
					end

					branch_local_list():add()
				end,
				desc = "Harpoon Add File",
			},
			{
				"<C-e>",
				function()
					harpoon.ui:toggle_quick_menu(branch_local_list())
				end,
				desc = "Harpoon Show List",
			},
			{
				"<C-j>",
				function()
					branch_local_list():select(1)
				end,
				desc = "Harpoon Buffer 1",
			},
			{
				"<C-k>",
				function()
					branch_local_list():select(2)
				end,
				desc = "Harpoon Buffer 2",
			},
			{
				"<C-l>",
				function()
					branch_local_list():select(3)
				end,
				desc = "Harpoon Buffer 3",
			},
			{
				"<leader>cb",
				function()
					harpoon.ui:toggle_quick_menu(branch_list)
				end,
				desc = "Harpoon Copy Branch List",
			},
		})

		-- terminals

		terminal_list:clear()
		terminal_list:add()
		terminal_list:add()
		terminal_list:add()

		require("which-key").add({
			group = "harpoon",
			{
				"<C-u>",
				function()
					terminal_list:select(1)
				end,
				desc = "Harpoon Term 1",
			},
			{
				"<C-i>",
				function()
					terminal_list:select(2)
				end,
				desc = "Harpoon Term 2",
			},

			{
				"<C-o>",
				function()
					terminal_list:select(3)
				end,
				desc = "Harpoon Term 3",
			},
		})
	end,
}
