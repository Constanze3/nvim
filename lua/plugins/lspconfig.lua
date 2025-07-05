return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "folke/which-key.nvim",
    },
    lazy = false,
    opts = {
        diagnostics = {
            underline = false,
        },
    },
    config = function()
        local capabilities = require("cmp_nvim_lsp").default_capabilities()
        local wk = require("which-key")

        vim.lsp.config("*", {
            capabilities = capabilities,
        })

        vim.lsp.config("ts_ls", {
            init_options = {
                plugins = {
                    {
                        name = "@vue/typescript-plugin",
                        location = "~/.nvm/versions/node/v22.17.0/lib/node_modules/@vue/typescript-plugin",
                        languages = { "javascript", "typescript", "vue" },
                    },
                },
            },
            filetypes = {
                "javascript",
                "typescript",
                "vue",
            },
        })

        vim.lsp.enable({ "phpactor", "ts_ls", "vue_ls", "lua_ls" })

        vim.api.nvim_create_autocmd("LspAttach", {
            callback = function(event)
                wk.add({
                    group = "lsp",
                    {
                        "K",
                        function()
                            vim.lsp.buf.hover()
                        end,
                        desc = "Hover",
                    },
                    {
                        "gd",
                        function()
                            vim.lsp.buf.definition()
                        end,
                        desc = "Go To Definition",
                    },
                    {
                        "gD",
                        function()
                            vim.lsp.buf.declaration()
                        end,
                        desc = "Go To Declaration",
                    },
                    {
                        "gi",
                        function()
                            vim.lsp.buf.implementation()
                        end,
                        desc = "Go To Implementation",
                    },
                    {
                        "go",
                        function()
                            vim.lsp.buf.type_definition()
                        end,
                        desc = "Go To Type Definition",
                    },
                    {
                        "gr",
                        function()
                            vim.lsp.buf.references()
                        end,
                        desc = "Show References",
                    },
                    {
                        "gs",
                        function()
                            vim.lsp.buf.signature_help()
                        end,
                        desc = "Signature Help",
                    },
                    {
                        "<F2>",
                        function()
                            vim.lsp.buf.rename()
                        end,
                        desc = "LSP Rename",
                    },
                    {
                        "<F3>",
                        function()
                            vim.lsp.buf.format({ async = true })
                        end,
                        desc = "LSP Format",
                        mode = { "n", "x" },
                    },
                    {
                        "<F4>",
                        function()
                            vim.lsp.buf.code_action()
                        end,
                        desc = "LSP Code Action",
                    },
                })
            end,
        })
    end,
}
