return {
    "stevearc/conform.nvim",
    init = function(_)
        table.insert(GLOBAL.packages, "stylua")
    end,
    opts = {
        formatters_by_ft = {
            lua = { "stylua" },
        },
    },
    cmd = { "ConformInfo" },
}
