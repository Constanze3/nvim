return {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.6",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
        { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Telescope | Files" },
        { "<leader>fg", "<cmd>Telescope live_grep<cr>",  desc = "Telescope | Grep" },
        { "<leader>fb", "<cmd>Telescope buffers<cr>",    desc = "Telescope | Files" },
        { "<leader>fh", "<cmd>Telescope help_tags<cr>",  desc = "Telescope | Files" },
    },
    opts = {
        defaults = {
            file_ignore_patterns = {
                "node_modules",
                "dist",
            }
        }
    },
}
