return {
    "neovim/nvim-lspconfig",
    opts = {
        diagnostics = {
            underline = false
        }
    },
    config = function() 
        local capabilities = require("cmp_nvim_lsp").default_capabilities()
        local lspconfig = require("lspconfig")

        lspconfig.rust_analyzer.setup({
            capabilities = capabilities

        })

        -- lspconfig.pyright.setup({
        --     capabilities = capabilities
        -- })
        
        lspconfig.clangd.setup({
            capabilities = capabilities
        })

        lspconfig.dartls.setup({
          capabilities = capabilities
        })

        vim.lsp.enable("phpactor")

    end
}

