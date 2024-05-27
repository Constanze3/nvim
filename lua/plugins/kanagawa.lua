return {
    "rebelot/kanagawa.nvim",
    init = function()
        vim.cmd("colorscheme kanagawa")
    end,
    opts = {
        transparent = true,
        commentStyle = { italic = false },
        keywordStyle = { italic = false },
        overrides = function()
            return {
                ["@variable.builtin"] = { italic = false },
            }
        end
    },
}
