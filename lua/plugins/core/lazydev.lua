return {
	"folke/lazydev.nvim",
	opts = {
		library = {
			-- See the configuration section for more details
			-- Load luvit types when the `vim.uv` word is found
			{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
		},
	},
	ft = "lua", -- only load on lua files
	enabled = require("custom/in_nvim").check(),
}
