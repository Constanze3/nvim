return {
    "nvim-treesitter/nvim-treesitter", 
    build = ":TSUpdate",
    config = function () 
        local configs = require("nvim-treesitter.configs")

        configs.setup({
            ensure_installed = { "python" },
            sync_install = false,
            highlight = { enable = true, disable = { "rust" } },
            indent = { enable = true, disable = { "rust" } },  
        })
    end
}
