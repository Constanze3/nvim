return {
    -- Checks whether the current working directory is the nvim directory or
    -- a descendant of the nvim directory with depth at most 5.
    check = function()
        local max_depth = 5

        local path = vim.fn.getcwd()
        local depth = 0

        while depth < max_depth do
            local dir = vim.fn.fnamemodify(path, ":t")
            if dir == "nvim" then
                return true
            end

            local parent = vim.fn.fnamemodify(path, ":h")
            if parent == path then
                -- reached root directory
                break
            end
            path = parent

            depth = depth + 1
        end

        return false
    end,
}
