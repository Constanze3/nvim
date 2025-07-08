return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "folke/which-key.nvim",
    },
    config = function()
        local harpoon = require("harpoon")

        require("which-key").add({
            group = "harpoon",
            icon = { icon = "󰛢", color = "red" },
            {
                "<leader>a",
                function()
                    harpoon:list():add()
                end,
                desc = "Harpoon Add File",
            },
            {
                "<C-e>",
                function()
                    harpoon.ui:toggle_quick_menu(harpoon:list())
                end,
                desc = "Harpoon Show List",
            },
            {
                "<C-j>",
                function()
                    harpoon:list():select(1)
                end,
                desc = "Harpoon Buffer 1",
            },
            {
                "<C-k>",
                function()
                    harpoon:list():select(2)
                end,
                desc = "Harpoon Buffer 2",
            },
            {
                "<C-l>",
                function()
                    harpoon:list():select(3)
                end,
                desc = "Harpoon Buffer 3",
            },
            {
                "<C-S-P>",
                function()
                    harpoon:list():prev()
                end,
                desc = "Harpoon Previous Buffer",
            },
            {
                "<C-S-N>",
                function()
                    harpoon:list():next()
                end,
                desc = "Harpoon Next Buffer",
            },
        })
    end,
}
