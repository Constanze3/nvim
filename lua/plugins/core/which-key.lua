return {
	"folke/which-key.nvim",
	init = function()
		local wk = require("which-key")

		wk.add({
			"<leader>w",
			wk.show,
			desc = "Which Key",
			icon = { icon = "", color = "blue" },
		})

		-- NETRW
		wk.add({
			"E",
			"<cmd>Explore<cr>",
			desc = "Open Netrw Explorer",
		})

		-- DIAGNOSTIC
		wk.add({
			"gl",
			function()
				vim.diagnostic.open_float()
			end,
			desc = "Open Diagnostic Pop-up",
		})

		-- DAP (Debug Adapter Protocol)
		wk.add({
			group = "dap",
			icon = { icon = "", color = "green" },
			{
				"<leader>db",
				function()
					require("dap").toggle_breakpoint()
				end,
				desc = "DAP Toggle Breakpoint",
				icon = { icon = "", color = "yellow" },
			},
			{
				"<leader>dB",
				function()
					require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
				end,
				desc = "DAP Breakpoint Condition",
				icon = { icon = "", color = "yellow" },
			},
			{
				"<leader>dc",
				function()
					require("dap").continue()
				end,
				desc = "DAP Run/Continue",
				icon = { icon = "󰐊", color = "red" },
			},
			-- TODO
			-- {
			--     "<leader>da",
			--     function() require("dap").continue({ before = get_args }) end,
			--     desc = "DAP Run With Args"
			-- },
			{
				"<leader>dC",
				function()
					require("dap").run_to_cursor()
				end,
				desc = "DAP Run To Cursor",
			},
			{
				"<leader>dg",
				function()
					require("dap").goto_()
				end,
				desc = "DAP Go To Line (No Execute)",
			},
			{
				"<leader>di",
				function()
					require("dap").step_into()
				end,
				desc = "DAP Step Into",
				icon = { icon = "󰆹", color = "red" },
			},
			{
				"<leader>dj",
				function()
					require("dap").down()
				end,
				desc = "DAP Down",
			},
			{
				"<leader>dk",
				function()
					require("dap").up()
				end,
				desc = "DAP Up",
			},
			{
				"<leader>dl",
				function()
					require("dap").run_last()
				end,
				desc = "DAP Run Last",
			},
			{
				"<leader>do",
				function()
					require("dap").step_out()
				end,
				desc = "DAP Step Out",
				icon = { icon = "󰆸", color = "red" },
			},
			{
				"<leader>ds",
				function()
					require("dap").step_over()
				end,
				desc = "DAP Step Over",
				icon = { icon = "󰆷", color = "red" },
			},
			{
				"<leader>dp",
				function()
					require("dap").pause()
				end,
				desc = "DAP Pause",
				icon = { icon = "", color = "red" },
			},
			{
				"<leader>dr",
				function()
					require("dap").repl.toggle()
				end,
				desc = "DAP Toggle REPL",
			},
			{
				"<leader>dS",
				function()
					require("dap").session()
				end,
				desc = "DAP Session",
			},
			{
				"<leader>dt",
				function()
					require("dap").terminate()
				end,
				desc = "DAP Terminate",
				icon = { icon = "", color = "red" },
			},
			{
				"<leader>dw",
				function()
					require("dap.ui.widgets").hover()
				end,
				desc = "DAP Widgets",
			},
			{
				"<leader>du",
				function()
					require("dapui").toggle()
				end,
				desc = "DAP Toggle UI",
			},
		})
	end,
}
