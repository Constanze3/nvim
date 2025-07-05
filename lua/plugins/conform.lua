return {
    "stevearc/conform.nvim",
    init = function(_)
        table.insert(global.packages, "stylua")
    end,
    opts = {
        formatters_by_ft = {
            lua = { "stylua" },
        },
    },
    cmd = { "ConformInfo" },
    keys = {
        {
            "<leader>f",
            function()
                require("conform").format({ async = true })
            end,
            mode = "",
            desc = "Format buffer",
        },
    },
}
