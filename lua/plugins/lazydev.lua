return {
    "folke/lazydev.nvim",
    init = function(_)
        table.insert(global.packages, "lua-language-server")
    end,
    opts = {
        library = {
            -- See the configuration section for more details
            -- Load luvit types when the `vim.uv` word is found
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        },
    },
    ft = "lua", -- only load on lua files
}
