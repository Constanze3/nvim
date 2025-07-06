return {
    "S1M0N38/love2d.nvim",
    event = "VeryLazy",
    config = function()
        require("love2d").setup()

        vim.lsp.config("lua_ls", {
            settings = {
                Lua = {
                    diagnostics = {
                        globals = { "love" },
                    },
                },
            },
        })
    end,
    enabled = not require("custom/in_nvim").check(),
}
