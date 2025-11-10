-- clipboard support for WSL
-- requires win32yank.exe to be installed on windows and be added to path
vim.g.clipboard = {
	name = "wsl_clipboard",
	copy = {
		["+"] = "win32yank.exe -i --crlf",
		["*"] = "win32yank.exe -i --crlf",
	},
	paste = {
		["+"] = "win32yank.exe -o --lf",
		["*"] = "win32yank.exe -o --lf",
	},
	cache_enabled = 0,
}

local wk = require("which-key")
wk.add({
	{
		"<C-c>",
		'"*y',
		desc = "Copy",
		mode = { "n", "i", "v" },
	},
	{
		"<C-v>",
		'"*p',
		desc = "Paste",
		mode = { "n", "i", "v" },
	},
})
