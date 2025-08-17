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
			term = {
				encode = false,
				create_list_item = function(_, _)
					local buf = vim.api.nvim_create_buf(true, false)

					vim.api.nvim_buf_call(buf, function()
						vim.cmd("term")
					end)

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
		})

		-- branch local harpoon list

		table.insert(PLUGIN_OUT.post_buffer_enter_callbacks, function()
			local list_name = vim.b.branch_name or ""

			require("which-key").add({
				group = "harpoon",
				icon = { icon = "󰛢", color = "red" },
				{
					"<leader>a",
					function()
						harpoon:list(list_name):add()
					end,
					desc = "Harpoon Add File",
				},
				{
					"<C-e>",
					function()
						harpoon.ui:toggle_quick_menu(harpoon:list(list_name))
					end,
					desc = "Harpoon Show List",
				},
				{
					"<C-j>",
					function()
						harpoon:list(list_name):select(1)
					end,
					desc = "Harpoon Buffer 1",
				},
				{
					"<C-k>",
					function()
						harpoon:list(list_name):select(2)
					end,
					desc = "Harpoon Buffer 2",
				},
				{
					"<C-l>",
					function()
						harpoon:list(list_name):select(3)
					end,
					desc = "Harpoon Buffer 3",
				},
			})
		end)

		-- terminals

		harpoon:list("term"):clear()
		harpoon:list("term"):add()
		harpoon:list("term"):add()
		harpoon:list("term"):add()

		require("which-key").add({
			group = "harpoon",
			{
				"<C-u>",
				function()
					harpoon:list("term"):select(1)
				end,
				desc = "Harpoon Term 1",
			},
			{
				"<C-i>",
				function()
					harpoon:list("term"):select(2)
				end,
				desc = "Harpoon Term 2",
			},

			{
				"<C-o>",
				function()
					harpoon:list("term"):select(3)
				end,
				desc = "Harpoon Term 3",
			},
		})
	end,
}
