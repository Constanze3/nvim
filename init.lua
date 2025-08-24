local ok, env = pcall(require, "env")
if not ok then
	vim.notify("Missing env.lua file!", vim.log.levels.ERROR)
end

local apply_settings = function()
	vim.g.mapleader = " "

	vim.opt.number = true

	-- do not wrap text
	-- vim.opt.wrap = false

	-- set indentation to be always done with spaces
	vim.opt.expandtab = true

	-- define the width of a <Tab> character (how \t is displayed)
	-- makes sure that files containing tabs look the sames as ones using 4 spaces
	vim.opt.tabstop = 4

	-- set the number of spaces <Tab> and <Backspace> inserts/deletes
	vim.opt.softtabstop = 4

	-- set the number of spaces that are inserted when (auto)indent (example: <) is used
	vim.opt.shiftwidth = 4
	-- (existing files can be converted to these settings with :retab)

	-- keep signcolumn always open (otherwise error/warning symbols can get annoying)
	vim.wo.signcolumn = "yes"

	-- set ESC as the back to normal mode key for the terminal
	vim.api.nvim_set_keymap("t", "<ESC>", "<C-\\><C-n>", { noremap = true })

	-- use F1 as an alternative to exit to normal mode fromn insert mode
	vim.api.nvim_set_keymap("i", "<F1>", "<ESC>", { noremap = false })
end

vim.g.apply_settings = apply_settings
apply_settings()

-- global variable used to collect information from individual plugins
PLUGIN_OUT = {
	packages = {},
	post_buffer_enter_callbacks = {},
}

-- install-path for lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- ensure that lazy.nvim is installed
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- auto update lazy plugins
vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		if require("lazy.status").has_updates() then
			require("lazy").update()
		end
	end,
})

-- load plugins with lazy.nvim from the plugins folder
require("lazy").setup({
	{ import = "plugins/core" },
	{ import = "plugins/themes" },
	{ import = "plugins" },
})

-- download/update mason packages
vim.api.nvim_create_autocmd("User", {
	pattern = "VeryLazy",
	callback = function()
		require("mason-tool-installer").setup({
			ensure_installed = PLUGIN_OUT.packages,
			auto_update = true,
		})
	end,
})

if env.wsl then
	-- load wsl support
	require("custom/wsl")
end

-- format on save
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	callback = function(args)
		require("conform").format({ bufnr = args.buf })
	end,
})

-- set theme
vim.cmd(string.format("colorscheme %s", env.theme))

-- before exiting close all terminal buffers
-- this prevents an error with wqa
vim.api.nvim_create_autocmd("ExitPre", {
	pattern = "*",
	callback = function()
		for _, buf in ipairs(vim.api.nvim_list_bufs()) do
			if vim.api.nvim_get_option_value("buftype", { buf = buf }) == "terminal" then
				vim.api.nvim_buf_delete(buf, { force = true })
			end
		end
	end,
})
