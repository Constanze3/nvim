-- clipboard support for WSL
-- requires win32yank.exe to be installed on windows
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
