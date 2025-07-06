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
        vim.lsp.config("*", {
            capabilities = capabilities,
        })

        local env = require("env")
        local util = require("custom/util")

        -- ensure the language servers to be installed by mason
        util.extend(GLOBAL.packages, env.language_servers)

        -- enable the language servers
        vim.lsp.enable(env.language_servers)

        -- if both vue_ls and ts_ls are enabled configure ts_ls to support vue
        if util.contains_multiple(env.language_servers, { "vue_ls", "ts_ls" }) then
            local vue_plugin_location = vim.fn.stdpath("data")
                .. "/mason/packages/vue-language-server/node_modules/@vue/language-server"

            vim.lsp.config("ts_ls", {
                init_options = {
                    plugins = {
                        {
                            name = "@vue/typescript-plugin",
                            location = vue_plugin_location,
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
        end

        vim.api.nvim_create_autocmd("LspAttach", {
            callback = function()
                require("which-key").add({
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
