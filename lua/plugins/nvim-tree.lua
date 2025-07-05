return {
	"nvim-tree/nvim-tree.lua",
	config = function()
		require("nvim-tree").setup({
			-- on_attach = function()
			--     local api = require("nvim-tree.api")
			--     local wk = require("which-key")

			--     local close_tree_and_open_netrw = function()
			--         local windows = vim.api.nvim_list_wins()
			--         if #windows == 1 then
			--             vim.cmd("vsplit")
			--             vim.cmd("Explore")
			--         end

			--         require("nvim-tree.api").tree.close()
			--     end
			--
			--     local close_netrw_and_open_tree = function()
			--         api.tree.open()

			--         for _, buf in ipairs(vim.api.nvim_list_bufs()) do
			--             if vim.api.nvim_buf_get_option(buf, "filetype") == "netrw" then
			--                 vim.api.nvim_buf_delete(buf, { force = true })
			--             end
			--         end
			--     end

			--     wk.add({
			--         "<leader>t",
			--         function()
			--             if api.tree.is_visible() then
			--                 close_tree_and_open_netrw()
			--             else
			--                 close_netrw_and_open_tree()
			--             end
			--         end,
			--         desc = "Toggle Nvim-Tree",
			--         icon = { icon = "󰙅", color = "green" }
			--     })

			--     -- initially close the tree
			--     close_tree_and_open_netrw()
			-- end
		})
	end,
}
