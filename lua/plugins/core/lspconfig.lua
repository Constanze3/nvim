return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"folke/which-key.nvim",
	},
	lazy = false,
	opts = {
		diagnostics = {
			underline = false,
		},
	},
	config = function()
		local capabilities = require("cmp_nvim_lsp").default_capabilities()
		vim.lsp.config("*", {
			capabilities = capabilities,
		})

		local env = require("env")
		local util = require("custom/util")

		-- ensure the language servers to be installed by mason
		util.extend(PLUGIN_OUT.packages, env.language_servers)

		-- enable the language servers
		vim.lsp.enable(env.language_servers)

		-- vue_ls + vtsls config
		-- based on https://github.com/vuejs/language-tools/wiki/Neovim

		local vue_ls_path = vim.fn.stdpath("data")
			.. "/mason/packages/vue-language-server/node_modules/@vue/language-server"

		local vue_plugin = vim.lsp.config("vtsls", {
			settings = {
				vtsls = {
					tsserver = {
						globalPlugins = {
							{
								name = "@vue/typescript-plugin",
								location = vue_ls_path,
								languages = { "vue" },
								configNamespace = "typescript",
							},
						},
					},
				},
			},
			filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
		})

		vim.lsp.config("vue_ls", {
			on_init = function(client)
				client.handlers["tsserver/request"] = function(_, result, context)
					local clients = vim.lsp.get_clients({ bufnr = context.bufnr, name = "vtsls" })
					if #clients == 0 then
						vim.notify(
							"Could not found `vtsls` lsp client, vue_lsp will not work without it.",
							vim.log.levels.ERROR
						)
						return
					end
					local ts_client = clients[1]

					local param = unpack(result)
					local id, command, payload = unpack(param)
					ts_client:exec_cmd({
						title = "vue_request_forward", -- You can give title anything as it's used to represent a command in the UI, `:h Client:exec_cmd`
						command = "typescript.tsserverRequest",
						arguments = {
							command,
							payload,
						},
					}, { bufnr = context.bufnr }, function(_, r)
						local response_data = { { id, r.body } }
						---@diagnostic disable-next-line: param-type-mismatch
						client:notify("tsserver/response", response_data)
					end)
				end
			end,
		})

		local tailwind_filetypes = util.copy(require("lspconfig.configs.tailwindcss").default_config.filetypes)
		util.extend(tailwind_filetypes, { "scss" })

		vim.lsp.config("tailwindcss", {
			filetypes = tailwind_filetypes,
		})

		vim.api.nvim_create_autocmd("LspAttach", {
			callback = function()
				require("which-key").add({
					group = "lsp",
					{
						"K",
						function()
							vim.lsp.buf.hover()
						end,
						desc = "Hover",
					},
					{
						"gd",
						function()
							vim.lsp.buf.definition()
						end,
						desc = "Go To Definition",
					},
					{
						"gD",
						function()
							vim.lsp.buf.declaration()
						end,
						desc = "Go To Declaration",
					},
					{
						"gi",
						function()
							vim.lsp.buf.implementation()
						end,
						desc = "Go To Implementation",
					},
					{
						"go",
						function()
							vim.lsp.buf.type_definition()
						end,
						desc = "Go To Type Definition",
					},
					{
						"gr",
						function()
							vim.lsp.buf.references()
						end,
						desc = "Show References",
					},
					{
						"gs",
						function()
							vim.lsp.buf.signature_help()
						end,
						desc = "Signature Help",
					},
					{
						"<F2>",
						function()
							vim.lsp.buf.rename()
						end,
						desc = "LSP Rename",
					},
					{
						"<F3>",
						function()
							vim.lsp.buf.format({ async = true })
						end,
						desc = "LSP Format",
						mode = { "n", "x" },
					},
					{
						"<F4>",
						function()
							vim.lsp.buf.code_action()
						end,
						desc = "LSP Code Action",
					},
				})
			end,
		})
	end,
}
