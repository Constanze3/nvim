return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = { "nvim-lua/plenary.nvim" },
	opts = {
		defaults = {
			file_ignore_patterns = {
				".git",
				"target",
				"node_modules",
				"_ide_helper.php",
				"_ide_helper_models.php",
			},
		},
	},
	config = function(_, opts)
		require("telescope").setup(opts)

		local icon = { icon = "", color = "cyan" }

		local builtin = require("telescope.builtin")
		local keybinds = {
			group = "telescope",
			{
				"<leader>f",
				desc = "Telescope",
			},
			{
				"<leader>ff",
				builtin.find_files,
				desc = "Find Files",
			},
			{
				"<leader>fg",
				builtin.live_grep,
				desc = "Live Grep",
			},
			{
				"<leader>fd",
				builtin.diagnostics,
				desc = "Diagnostics",
			},
			{
				"<leader>fb",
				builtin.buffers,
				desc = "Buffers",
			},
			{
				"<leader>fh",
				builtin.help_tags,
				desc = "Help Tags",
			},
			{
				"<leader>fv",
				function()
					builtin.find_files({ hidden = true })
				end,
				desc = "Find Hidden Files",
			},
		}

		for _, keybind in ipairs(keybinds) do
			keybind["icon"] = icon
		end

		require("which-key").add(keybinds)
	end,
}
