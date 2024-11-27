return {
    "rebelot/kanagawa.nvim",
    opts = {
        transparent = false,
        commentStyle = { italic = false },
        keywordStyle = { italic = false },
        overrides = function()
            return {
                ["@variable.builtin"] = { italic = false },
            }
        end
    }
}
