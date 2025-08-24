return {
	"stevearc/conform.nvim",
	init = function(_)
		local util = require("custom/util")
		local env = require("env")
		util.extend(PLUGIN_OUT.packages, env.formatters)
	end,
	opts = {
		format_on_save = {
			timeout_ms = 500,
			lsp_format = "fallback",
		},
		formatters_by_ft = {
			html = { "prettier" },
			typescript = { "prettier" },
			lua = { "stylua" },
			vue = { "prettier" },
			python = { "black" },
			php = { "php_cs_fixer" },
		},
	},
	config = function(_, opts)
		local conform = require("conform")
		conform.setup(opts)

		conform.formatters.php_cs_fixer = {
			command = "php-cs-fixer",
		}
	end,
	cmd = { "ConformInfo" },
}
