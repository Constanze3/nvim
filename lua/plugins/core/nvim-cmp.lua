return {
    "hrsh7th/nvim-cmp",
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/vim-vsnip",
        "hrsh7th/cmp-vsnip",
    },
    config = function()
        local cmp = require("cmp")
        cmp.setup({
            sources = cmp.config.sources({
                { name = "nvim_lsp" },
                { name = "vsnip" },
                { name = "lazydev", group_index = 0 },
            }),
            snippet = {
                expand = function(args)
                    vim.fn["vsnip#anonymous"](args.body)
                end,
            },
            mapping = cmp.mapping.preset.insert({
                -- Enter key to confirm completion
                ["<CR>"] = cmp.mapping.confirm({ select = false }),

                -- Ctrl+Space to trigger completion menu
                ["<C-Space>"] = cmp.mapping.complete(),

                -- Scroll up and down in the completion documentation
                ["<C-u>"] = cmp.mapping.scroll_docs(-4),
                ["<C-d>"] = cmp.mapping.scroll_docs(4),
            }),
        })
    end,
}
